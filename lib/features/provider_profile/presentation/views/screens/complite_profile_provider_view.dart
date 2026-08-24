
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:servi_go_app/features/provider_profile/data/models/complete_profile_model.dart';

import 'package:servi_go_app/features/provider_profile/presentation/view_models/completeprofile/complete_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/completeprofile/complete_profile_state.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/sub_services/sub_services_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/sub_services/sub_services_state.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/Certificates%20_section.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/Profile_photo_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/holiday_days_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/price_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/my_portfolio_section.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/sub_category_dropdown.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/working_hours_picker.dart';

class CompliteProfileProviderView extends StatefulWidget {
  final String userType;
  final Map<String, dynamic>? userData;
  const CompliteProfileProviderView({super.key, this.userData, required this.userType});

  @override
  State<CompliteProfileProviderView> createState() => _CompliteProfileProviderViewState();
}

class _CompliteProfileProviderViewState extends State<CompliteProfileProviderView> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();

  int? selectedSubServiceId;
  List<String> userHolidayDays = [];

  String _startTime24 = "08:00";
  String _endTime24 = "16:00";
  double _minPrice = 0.0;
  double _maxPrice = 0.0;
  File? _profilePhoto;

  List<PortfolioItem> _portfolioItems = [];
  List<File> _certificateFiles = [];

  @override
  void initState() {
    super.initState();

    // 👇 معدّل: بقت nullable عشان نقدر نفرق بين "معرفناش القيمة"
    // و"القيمة الحقيقية هي 1"، والـ default بيتحط في الآخر بس
    int? dynamicMainServiceId;

    if (widget.userData != null) {
      if (widget.userData!.containsKey('main_service_id') && widget.userData!['main_service_id'] != null) {
        dynamicMainServiceId = int.tryParse(widget.userData!['main_service_id'].toString());
      }
      else if (widget.userData!['data'] is Map && widget.userData!['data'].containsKey('main_service_id') && widget.userData!['data']['main_service_id'] != null) {
        dynamicMainServiceId = int.tryParse(widget.userData!['data']['main_service_id'].toString());
      }
      else if (widget.userData!['user'] is Map && widget.userData!['user'].containsKey('main_service_id') && widget.userData!['user']['main_service_id'] != null) {
        dynamicMainServiceId = int.tryParse(widget.userData!['user']['main_service_id'].toString());
      }
      else if (widget.userData!['data'] is Map && widget.userData!['data']['user'] is Map && widget.userData!['data']['user'].containsKey('main_service_id')) {
        dynamicMainServiceId = int.tryParse(widget.userData!['data']['user']['main_service_id'].toString());
      }
    }

    // 👇 جديد: لو مفيش قيمة جاية مع userData (زي حالة "أول دخول بعد الموافقة")،
    // نجرب نجيبها من الكاش اللي بيتحفظ في fetchAndSaveProfileAfterLogin
    if (dynamicMainServiceId == null) {
      final cachedId = PrefHelper.getString('main_service_id');
      if (cachedId != null && cachedId.isNotEmpty) {
        dynamicMainServiceId = int.tryParse(cachedId);
      }
    }

    // آخر حل احتياطي فقط لو فشلت كل المحاولات فوق
    dynamicMainServiceId ??= 1;

    BlocProvider.of<SubServicesCubit>(context).fetchSubServices(dynamicMainServiceId);
  }

  String _convertTo24Hour(int hour, String period) {
    if (period.toUpperCase() == "PM" && hour < 12) hour += 12;
    if (period.toUpperCase() == "AM" && hour == 12) hour = 0;
    return "${hour.toString().padLeft(2, '0')}:00";
  }

  @override
  void dispose() {
    _locationController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

 @override
 Widget build(BuildContext context) {
   final l10n = AppLocalizations.of(context)!;
   final theme = Theme.of(context);
   final isDark = theme.brightness == Brightness.dark;
   final containerColor = isDark ? theme.cardColor : const Color(0xFFF3F2F2);
   final dividerColor = theme.dividerColor;

   return Scaffold(
     body: BlocListener<CompleteProfileCubit, CompleteProfileState>(
       listener: (context, state) async {
         if (state is CompleteProfileSuccess) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(state.response.message), backgroundColor: Colors.green),
           );
           if (_profilePhoto != null) {
             await PrefHelper.saveUserImage(_profilePhoto!.path);
             if (!context.mounted) return;
           }

           GoRouter.of(context).push(
             AppRouter.kHome,
             extra: {
               'userType': widget.userType,
               'userData': state.response,
             },
           );
         } else if (state is CompleteProfileFailure) {
           ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
           );
         }
       },
       child: AppBackground(
         padding: EdgeInsets.only(top: 45.h),
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               children: [
                 ProfilePhotoWidget(
                   onPhotoSelected: (File file) {
                     _profilePhoto = file;
                   },
                 ),
                 Gap(10),
                 Container(
                   width: 353.w,
                   decoration: BoxDecoration(
                     color: containerColor,
                     borderRadius: BorderRadius.circular(18.r),
                   ),
                   child: SingleChildScrollView(
                     physics: const NeverScrollableScrollPhysics(),
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: EdgeInsets.only(top: 14.h, left: 10.h),
                           child: Text(
                             l10n.completeYourProfile,
                             style: TextStyles.onCard(context, TextStyles.font16BlackW700),
                           ),
                         ),
                         Divider(color: dividerColor, thickness: 0.8),
                         Gap(11),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20.0),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 l10n.locationDescription,
                                 style: TextStyles.onCard(context, TextStyles.font16PrimaryColorW600),
                               ),
                               CustomTextFormFiled(
                                 controller: _locationController,
                                 hintText: l10n.enterLocationDescription,
                                 borderSide: const BorderSide(width: 0.1, color: Colors.white),
                                 borderRadius: const BorderRadius.all(Radius.circular(2)),
                               ),
                               Gap(20),
                               Text(
                                 l10n.aboutMe,
                                 style: TextStyles.font16PrimaryColorW600,
                               ),
                               CustomTextFormFiled(
                                 controller: _aboutMeController,
                                 hintText: l10n.describeYourself,
                                 hintStyle: TextStyles.font11BlackW400,
                                 borderSide: const BorderSide(width: 0.1, color: Colors.white),
                                 borderRadius: const BorderRadius.all(Radius.circular(2)),
                               ),
                               Gap(20),
                             ],
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10.h),
                           child: BlocBuilder<SubServicesCubit, SubServicesState>(
                             builder: (context, state) {
                               if (state is SubServicesLoading) {
                                 return const Center(
                                   child: Padding(
                                     padding: EdgeInsets.all(8.0),
                                     child: CircularProgressIndicator(),
                                   ),
                                 );
                               } else if (state is SubServicesSuccess) {
                                 return SubCategoryDropdown(
                                   subServices: state.subServices,
                                   selectedId: selectedSubServiceId,
                                   onChanged: (int? newValue) {
                                     setState(() {
                                       selectedSubServiceId = newValue;
                                     });
                                   },
                                 );
                               } else if (state is SubServicesFailure) {
                                 return Center(
                                   child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Text(
                                       l10n.failedToLoadSubServices,
                                       style: TextStyle(color: Colors.red, fontSize: 13.sp),
                                     ),
                                   ),
                                 );
                               }
                               return const SizedBox();
                             },
                           ),
                         ),
                         Gap(20),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10.h),
                           child: Text(
                             l10n.setPriceForServices,
                             style: TextStyles.onCard(context, TextStyles.font14PrimaryColorW700),
                           ),
                         ),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10.h),
                           child: PriceWidget(
                             onPriceChanged: (min, max) {
                               setState(() {
                                 _minPrice = double.tryParse(min) ?? 0.0;
                                 _maxPrice = double.tryParse(max) ?? 0.0;
                               });
                             },
                           ),
                         ),
                         Gap(20),
                         CustomTimePicker(
                           onTimeChanged: (startHour, startPeriod, endHour, endPeriod) {
                             _startTime24 = _convertTo24Hour(startHour, startPeriod);
                             _endTime24 = _convertTo24Hour(endHour, endPeriod);
                           },
                         ),
                         Gap(20),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 10.h),
                           child: Text(
                             l10n.specifyHolidayDays,
                             style: TextStyles.onCard(context, TextStyles.font14PrimaryColorW700),
                           ),
                         ),
                         Gap(20),
                         Padding(
                           padding: EdgeInsets.symmetric(horizontal: 12.w),
                           child: HolidayDaysWidget(
                             onDaysChanged: (List<String> selectedDaysList) {
                               userHolidayDays = selectedDaysList;
                             },
                           ),
                         ),
                         Gap(27),
                       ],
                     ),
                   ),
                 ),
                 Gap(20),
                 MyPortfolioSection(
                   onPortfolioChanged: (items) {
                     setState(() {
                       _portfolioItems = items;
                     });
                   },
                 ),
                 Gap(20),
                 CertificatesSection(
                   onCertificatesChanged: (files) {
                     setState(() {
                       _certificateFiles = files;
                     });
                   },
                 ),
                 Gap(35),
                 BlocBuilder<CompleteProfileCubit, CompleteProfileState>(
                   builder: (context, state) {
                     if (state is CompleteProfileLoading) {
                       return const CircularProgressIndicator();
                     }
                     return CustomButton(
                       width: 205.w,
                       height: 30.h,
                       title: l10n.completeProfile,
                       textstyle: TextStyles.font20White800.copyWith(fontSize: 17.sp),
                       onTap: () {
                         if (_locationController.text.isEmpty ||
                             _aboutMeController.text.isEmpty ||
                             selectedSubServiceId == null ||
                             _profilePhoto == null) {
                           ScaffoldMessenger.of(context).showSnackBar(
                             SnackBar(
                               content: Text(l10n.fillProviderRequiredFields),
                               backgroundColor: Colors.orange,
                             ),
                           );
                           return;
                         }

                         final profileModel = CompleteProfileModel(
                           photo: _profilePhoto!,
                           locationDescription: _locationController.text,
                           aboutMe: _aboutMeController.text,
                           subServiceId: selectedSubServiceId!,
                           offDays: userHolidayDays,
                           workStartTime: _startTime24,
                           workEndTime: _endTime24,
                           minPrice: _minPrice == 0.0 ? 10000.0 : _minPrice,
                           maxPrice: _maxPrice == 0.0 ? 20000.0 : _maxPrice,
                           portfolio: _portfolioItems.map((item) => PortfolioInput(
                             file: item.file,
                             description: item.description,
                           )).toList(),
                           certificates: _certificateFiles,
                         );

                         BlocProvider.of<CompleteProfileCubit>(context)
                             .submitCompleteProfile(profileModel);
                       },
                     );
                   },
                 ),
               ],
             ),
           ),
         ),
       ),
     ),
   );
 }
}