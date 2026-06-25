import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/app_colors.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:servi_go_app/features/map/presentation/views/screens/map_view.dart';
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
  final TextEditingController nameController = TextEditingController(
    text: 'Ahmed Al-Rashid',
  );
  final TextEditingController emailController = TextEditingController(
    text: 'ali@gmail.com',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '+966512345679',
  );
  final TextEditingController locationController = TextEditingController(
    text: 'New Office Location',
  );
  final TextEditingController locationDetailsController = TextEditingController(
    text: 'Next to mall entrance A',
  );
  final TextEditingController aboutMeController = TextEditingController(
    text: 'Updated experience description',
  );
  final TextEditingController startTimeController = TextEditingController(
    text: '09:00',
  );
  final TextEditingController endTimeController = TextEditingController(
    text: '22:00',
  );
  final TextEditingController minPriceController = TextEditingController(
    text: '350',
  );
  final TextEditingController maxPriceController = TextEditingController(
    text: '2000',
  );

  // ── State ──
  double? latitude = 24.8000;
  double? longitude = 46.7000;
  String workType = 'mobile'; // fixed / mobile / both
  String currency = 'SYP';

  // ── Portfolio / Certificates ──
  List<PortfolioItem> portfolioItems = [];
  List<File> certificateFiles = [];

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

  // ── إرسال الطلب ──
  void _updateProfile() {
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

    debugPrint(body.toString());

    // TODO: استدعاء PUT /api/provider/profile

    // TODO: إذا وجد portfolioItems جديدة → POST /api/provider/gallery
    // TODO: إذا وجد certificateFiles جديدة → POST /api/provider/profile/certificates
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: AppBackground(
        withScaffold: false,
        child: SingleChildScrollView(
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
                      hintText: 'SYR',

                      width: double.infinity,
                    ),
                  ),
                ],
              ),

              Gap(20.h),
              const Divider(),
              Gap(16.h),

              // ============ Security ============
              _sectionTitle('Security'),
              Gap(10.h),

              InkWell(
                onTap: () {
                 
                },
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 18.sp,
                        color: Theme.of(context).textTheme.bodyMedium?.color,
                      ),
                      Gap(8.w),
                      Text(
                        'Change Password',
                        style: TextStyles.font11BlackW400,
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14.sp,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ],
                  ),
                ),
              ),

              Gap(20.h),
              const Divider(),
              Gap(16.h),

            
              MyPortfolioSection(
                onPortfolioChanged: (items) {
                  setState(() => portfolioItems = items);
                },
              ),

              Gap(16.h),

           
              CertificatesSection(
                onCertificatesChanged: (files) {
                  setState(() => certificateFiles = files);
                },
              ),

              Gap(24.h),
              CustomButton(
                width: double.infinity,
                height: 48.h,
                onTap: () => _updateProfile,
                title: 'Update Info',
                textstyle: TextStyles.font15WhiteColorW500,
              ),

              Gap(24.h),
            ],
          ),
        ),
      ),
    );
  }

  // ── Section Title ──
  Widget _sectionTitle(String title) {
    return Text(title, style: TextStyles.font14PrimaryColorW700);
  }

  // ── Work Type Selector ──
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

  // ── Time Picker ──
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
