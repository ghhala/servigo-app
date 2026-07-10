import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/Validators_widget.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/terms_and_conditions_widget%20.dart';
import 'package:servi_go_app/features/map/presentation/views/screens/map_view.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/features/auth/data/models/register_provider_request_body.dart';

class SignUplabourerView extends StatefulWidget {
  final String userType;

  const SignUplabourerView({super.key, required this.userType});

  @override
  State<SignUplabourerView> createState() => _SignUplabourerViewState();
}

class _SignUplabourerViewState extends State<SignUplabourerView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController locationController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationDetailsController = TextEditingController();
  String? selectedRegion;
  String? selectedService;

  double? selectedLatitude;
  double? selectedLongitude;

  @override
  void dispose() {
    locationController.dispose();
    regionController.dispose();
    serviceController.dispose();
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    locationDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: SvgPicture.asset(Assets.logo),
                ),
                Gap(28.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      Text(
                        AppLocalizations.of(context)!.createLabourerAccount,
                        style: TextStyles.font18BlackW500,
                      ),
                      Gap(5.w),
                      SvgPicture.asset("assets/images/labourer_icon.svg"),
                    ],
                  ),
                ),

                Gap(20.h),

                Column(
                  children: [
                    CustomTextFormFiled(
                      validator: Validators.fullName,
                      controller: fullNameController,
                      hintText: AppLocalizations.of(context)!.fullName,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset("assets/images/name_icon.svg"),
                      ),
                      textInputType: TextInputType.name,
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      validator: Validators.phone,
                      controller: phoneController,
                      hintText: AppLocalizations.of(context)!.phoneNumber,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset("assets/images/phone_icon.svg"),
                      ),
                      textInputType: TextInputType.number,
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      validator: Validators.email,
                      controller: emailController,
                      hintText: AppLocalizations.of(context)!.emailAddress,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset("assets/images/iconEmail.svg"),
                      ),
                      textInputType: TextInputType.emailAddress,
                    ),
                    Gap(20.h),
                    GestureDetector(
                      onTap: () async {
                        final result = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                const CustomLocation(), // ← لا تغيير هنا
                          ),
                        );

                        debugPrint("Result received from map: $result");

                        if (result != null && result is Map) {
                          if (mounted) {
                            setState(() {
                              selectedLatitude = result['lat'];
                              selectedLongitude = result['lng'];
                              locationController.text = result['name'] ?? '';
                            });
                          }
                        }
                      },
                      child: AbsorbPointer(
                        child: CustomTextFormFiled(
                          controller: locationController,
                          hintText: AppLocalizations.of(context)!.location,
                          readOnly: true,
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(11.w),
                            child: SvgPicture.asset(
                              "assets/images/location_icon.svg",
                            ),
                          ),
                          textInputType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.pleaseSelectLocationFromMap;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      controller: serviceController,
                      hintText: AppLocalizations.of(context)!.chooseService,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.w),
                        child: SvgPicture.asset(
                          "assets/images/iconservice.svg",
                        ),
                      ),
                      isDropdown: true,
                      value: selectedService,
                      items: const ['Cleaning', 'Plumbing', 'Electrical'],
                      validator: (value) {
                        if (value == null) {
                          return AppLocalizations.of(
                            context,
                          )!.pleaseSelectService;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedService = value;
                        });
                      },
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      controller: regionController,
                      hintText: AppLocalizations.of(context)!.workType,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.w),
                        child: SvgPicture.asset(
                          "assets/images/region_icon.svg",
                        ),
                      ),
                      isDropdown: true,
                      value: selectedRegion,
                      items: const ['Fixed', 'Mobile', 'Both'],
                      validator: (value) {
                        if (value == null) {
                          return AppLocalizations.of(
                            context,
                          )!.pleaseSelectRegion;
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedRegion = value;
                        });
                      },
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      controller: passwordController,
                      validator: Validators.password,
                      hintText: AppLocalizations.of(context)!.password,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.w),
                        child: SvgPicture.asset(
                          "assets/images/password_icon.svg",
                        ),
                      ),
                      textInputType: TextInputType.text,
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.w),
                        child: SvgPicture.asset(
                          "assets/images/password_icon.svg",
                        ),
                      ),
                      textInputType: TextInputType.text,
                    ),
                    Gap(25.h),
                    TermsAndConditionsWidget(onChanged: (bool value) {}),
                    Gap(56.h),
                    CustomButton(
                      title: AppLocalizations.of(context)!.next,
                      textstyle: TextStyles.font20White800,
                      width: MediaQuery.sizeOf(context).width * 0.88,
                      height: 52.h,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (selectedLatitude == null ||
                              selectedLongitude == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "الرجاء فتح الخريطة وتأكيد موقعك أولاً",
                                ),
                                backgroundColor: Colors.orange,
                              ),
                            );
                            return;
                          }

                          String formattedWorkType = selectedRegion!
                              .toLowerCase();

                          String serviceId = "1";
                          if (selectedService == 'Cleaning') serviceId = "1";
                          if (selectedService == 'Plumbing') serviceId = "2";
                          if (selectedService == 'Electrical') serviceId = "3";

                          final requestBody = RegisterProviderRequestBody(
                            name: fullNameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                            password: passwordController.text.trim(),
                            passwordConfirmation: passwordController.text
                                .trim(),
                            locationName: locationController.text.trim(),
                            mainServiceId: serviceId,
                            workType: formattedWorkType,
                            latitude: selectedLatitude,
                            longitude: selectedLongitude,
                          );

                          GoRouter.of(
                            context,
                          ).push(AppRouter.kVerviciton, extra: requestBody);
                        }
                      },
                    ),
                    Gap(30.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
