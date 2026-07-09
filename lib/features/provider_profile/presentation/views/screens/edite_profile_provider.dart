import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/app_colors.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:servi_go_app/features/map/presentation/views/screens/map_view.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_state.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/Certificates%20_section.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/my_portfolio_section.dart';

class EditProfileProviderView extends StatefulWidget {
  const EditProfileProviderView({super.key});

  @override
  State<EditProfileProviderView> createState() =>
      _EditProfileProviderViewState();
}

class _EditProfileProviderViewState extends State<EditProfileProviderView> {
  // ── Controllers ──
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController locationDetailsController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  // ── State ──
  double? latitude;
  double? longitude;
  String workType = 'mobile';
  String currency = 'SYP';
  bool _isSaving = false;
  bool _dataLoadedOnce = false;

  // ── Portfolio / Certificates (عناصر جديدة) ──
  List<PortfolioItem> portfolioItems = [];
  List<File> certificateFiles = [];
  List<int> removedPortfolioIds = [];
  List<int> removedCertificateIds = [];

  @override
  void initState() {
    super.initState();
    context.read<ProviderProfileCubit>().fetchProviderProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    locationController.dispose();
    locationDetailsController.dispose();
    aboutMeController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  String _formatPriceForEdit(String? rawPrice) {
    if (rawPrice == null || rawPrice.isEmpty) return '';
    final parsed = double.tryParse(rawPrice) ?? 0;
    if (parsed == parsed.roundToDouble()) {
      return parsed.toInt().toString();
    }
    return parsed.toString();
  }

  void _populateFieldsFromProfile(ProviderProfileState state) {
    if (_dataLoadedOnce) return;
    if (state is! ProviderProfileSuccess) return;

    final data = state.profileModel.data;
    final user = data?.user;
    final provider = data?.provider;

    nameController.text = user?.name ?? '';
    emailController.text = user?.email ?? '';
    phoneController.text = user?.phone ?? '';
    locationController.text = provider?.locationName ?? '';
    locationDetailsController.text = provider?.locationDescription ?? '';
    aboutMeController.text = provider?.aboutMe ?? '';
    startTimeController.text = provider?.workStartTime ?? '09:00';
    endTimeController.text = provider?.workEndTime ?? '18:00';

    minPriceController.text = _formatPriceForEdit(provider?.minPrice);
    maxPriceController.text = _formatPriceForEdit(provider?.maxPrice);

    latitude = double.tryParse(provider?.latitude ?? '');
    longitude = double.tryParse(provider?.longitude ?? '');
    workType = provider?.workType ?? 'mobile';
    currency = provider?.currency ?? 'SYP';

    _dataLoadedOnce = true;
  }

  Future<void> _openMap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CustomLocation()),
    );

    if (result != null) {
      setState(() {
        latitude = result['lat'];
        longitude = result['lng'];
        locationController.text = result['name'];
      });
    }
  }

  
Future<void> _updateProfile() async {
  final body = {
    "name": nameController.text,
    "phone": phoneController.text,
    "location_name": locationController.text,
    "latitude": latitude,
    "longitude": longitude,
    "location_description": locationDetailsController.text,
    "work_type": workType,
    "currency": currency,
    "min_price": int.tryParse(minPriceController.text) ?? 0,
    "max_price": int.tryParse(maxPriceController.text) ?? 0,
    "work_start_time": startTimeController.text,
    "work_end_time": endTimeController.text,
    "about_me": aboutMeController.text,
  };

  setState(() => _isSaving = true);

  try {
    final cubit = context.read<ProviderProfileCubit>();

   
    await cubit.updateProviderProfile(body);

   
    if (portfolioItems.isNotEmpty || removedPortfolioIds.isNotEmpty) {
      await cubit.updateGallery(
        newItems: portfolioItems
            .map((item) => {
                  'file': item.file,
                  'description': item.description,
                })
            .toList(),
        removeIds: removedPortfolioIds,
      );
    }

   
    if (certificateFiles.isNotEmpty || removedCertificateIds.isNotEmpty) {
      await cubit.updateCertificates(
        newFiles: certificateFiles,
        removeIds: removedCertificateIds,
      );
    }

  
    await cubit.fetchProviderProfile();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("update profile successfully"),
        backgroundColor: Colors.green,
      ),
    );

    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) Navigator.pop(context, true);
  } catch (e) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("فشل تحديث البروفايل: $e"),
        backgroundColor: Colors.red,
      ),
    );
  } finally {
    if (mounted) setState(() => _isSaving = false);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: AppBackground(
        withScaffold: false,
        child: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
          listener: (context, state) {
            _populateFieldsFromProfile(state);
          },
          builder: (context, state) {
            if (state is ProviderProfileLoading && !_dataLoadedOnce) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProviderProfileFailure && !_dataLoadedOnce) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: () => context
                            .read<ProviderProfileCubit>()
                            .fetchProviderProfile(),
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                ),
              );
            }

            _populateFieldsFromProfile(state);

            final existingPortfolio = state is ProviderProfileSuccess
                ? (state.profileModel.data?.portfolio ?? [])
                    .map((p) => ExistingPortfolioItem(
                          id: p.id ?? 0,
                          fileUrl: p.filePath ?? '',
                          fileType: p.fileType ?? 'image',
                          description: p.description ?? '',
                        ))
                    .toList()
                : <ExistingPortfolioItem>[];

            final existingCertificates = state is ProviderProfileSuccess
                ? (state.profileModel.data?.certificates ?? [])
                    .map((c) => ExistingCertificateItem(
                          id: c.id ?? 0,
                          fileUrl: c.filePath ?? '',
                        ))
                    .toList()
                : <ExistingCertificateItem>[];

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle('Account Info'),
                  Gap(10.h),

                  CustomTextFormFiled(
                    hintText: 'Full Name',
                    prefixIcon: const Icon(Icons.person_outline),
                    controller: nameController,
                  ),
                  Gap(10.h),

                  CustomTextFormFiled(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    controller: emailController,
                    readOnly: true,
                    fillColor: Theme.of(context).disabledColor.withOpacity(0.05),
                  ),
                  Gap(10.h),

                  CustomTextFormFiled(
                    hintText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone_outlined),
                    controller: phoneController,
                    textInputType: TextInputType.phone,
                  ),

                  Gap(20.h),
                  const Divider(),
                  Gap(16.h),

                  _sectionTitle('Location'),
                  Gap(10.h),

                  GestureDetector(
                    onTap: _openMap,
                    child: AbsorbPointer(
                      child: CustomTextFormFiled(
                        hintText: 'Location',
                        prefixIcon: const Icon(Icons.location_on_outlined),
                        controller: locationController,
                        readOnly: true,
                      ),
                    ),
                  ),
                  Gap(10.h),

                  CustomTextFormFiled(
                    hintText: 'Location Details',
                    prefixIcon: const Icon(Icons.edit_location_alt_outlined),
                    controller: locationDetailsController,
                  ),

                  Gap(20.h),
                  const Divider(),
                  Gap(16.h),

                  _sectionTitle('About Me'),
                  Gap(10.h),

                  CustomTextFormFiled(
                    hintText: 'Describe yourself in a few words',
                    controller: aboutMeController,
                    height: 70.h,
                  ),

                  const Divider(),
                  Gap(10.h),

                  _sectionTitle('Work Type'),
                  Gap(10.h),
                  _buildWorkTypeSelector(),

                  Gap(20.h),
                  const Divider(),
                  Gap(16.h),

                  _sectionTitle('Working Hours'),
                  Gap(10.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormFiled(
                          hintText: '09:00',
                          prefixIcon: const Icon(Icons.access_time),
                          controller: startTimeController,
                          readOnly: true,
                          width: double.infinity,
                          onTap_: () => _pickTime(startTimeController),
                        ),
                      ),
                      Gap(10.w),
                      Icon(
                        Icons.arrow_forward,
                        size: 16.sp,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                      Gap(10.w),
                      Expanded(
                        child: CustomTextFormFiled(
                          hintText: '22:00',
                          prefixIcon: const Icon(Icons.access_time),
                          controller: endTimeController,
                          readOnly: true,
                          width: double.infinity,
                          onTap_: () => _pickTime(endTimeController),
                        ),
                      ),
                    ],
                  ),

                  Gap(20.h),
                  const Divider(),
                  Gap(16.h),

                  _sectionTitle('Price'),
                  Gap(10.h),

                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormFiled(
                          hintText: 'Min',
                          controller: minPriceController,
                          textInputType: TextInputType.number,
                          width: double.infinity,
                        ),
                      ),
                      Gap(10.w),
                      Text('—', style: TextStyles.font11WhiteW500),
                      Gap(10.w),
                      Expanded(
                        child: CustomTextFormFiled(
                          hintText: 'Max',
                          controller: maxPriceController,
                          textInputType: TextInputType.number,
                          width: double.infinity,
                        ),
                      ),
                      Gap(10.w),
                      SizedBox(
                        width: 80.w,
                        child: CustomTextFormFiled(
                          hintText: currency,
                          width: double.infinity,
                        ),
                      ),
                    ],
                  ),

                  Gap(20.h),
                  const Divider(),
                  Gap(16.h),

                  MyPortfolioSection(
                    initialItems: existingPortfolio,
                    onPortfolioChanged: (items) {
                      setState(() => portfolioItems = items);
                    },
                    onExistingItemsRemoved: (ids) {
                      setState(() => removedPortfolioIds = ids);
                    },
                  ),

                  Gap(16.h),

                  CertificatesSection(
                    initialItems: existingCertificates,
                    onCertificatesChanged: (files) {
                      setState(() => certificateFiles = files);
                    },
                    onExistingItemsRemoved: (ids) {
                      setState(() => removedCertificateIds = ids);
                    },
                  ),

                  Gap(24.h),
                  CustomButton(
                    width: double.infinity,
                    height: 48.h,
                    onTap: _isSaving ? null : () => _updateProfile(),
                    title: _isSaving ? 'Saving...' : 'Update Info',
                    textstyle: TextStyles.font15WhiteColorW500,
                  ),

                  Gap(24.h),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(title, style: TextStyles.font14PrimaryColorW700);
  }

  Widget _buildWorkTypeSelector() {
    final options = ['fixed', 'mobile', 'both'];
    final labels = {'fixed': 'Fixed', 'mobile': 'Mobile', 'both': 'Both'};

    return Row(
      children: options.map((option) {
        final isSelected = workType == option;
        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => workType = option),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color.fromARGB(255, 179, 147, 186)
                    : AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Theme.of(context).dividerColor,
                ),
              ),
              child: Text(
                labels[option]!,
                textAlign: TextAlign.center,
                style: isSelected
                    ? TextStyles.font11WhiteW500
                    : TextStyles.font11BlackW400,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _pickTime(TextEditingController controller) async {
    final parts = controller.text.split(':');
    final initial = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 9,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
    );

    final picked = await showTimePicker(context: context, initialTime: initial);

    if (picked != null) {
      final hour = picked.hour.toString().padLeft(2, '0');
      final minute = picked.minute.toString().padLeft(2, '0');
      setState(() => controller.text = '$hour:$minute');
    }
  }
}