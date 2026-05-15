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
import 'package:servi_go_app/features/auth/presentation/views/widgets/or_divider%20.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/social_auth_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/terms_and_conditions_widget%20.dart';
import 'package:servi_go_app/features/map/presentation/views/screens/map_view.dart';

class SignUplabourerView extends StatefulWidget {
  const SignUplabourerView({super.key});

  @override
  State<SignUplabourerView> createState() => _SignUplabourerViewState();
}

class _SignUplabourerViewState extends State<SignUplabourerView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController locationController = TextEditingController();
  String? selectedRegion;
  String? selectedService;

  @override
  void dispose() {
    locationController.dispose(); // ← مهم
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: AppBackground(
        child: Positioned(
          right: 0,
          top: 150.h,
          left: 0,
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
                        Icon(Icons.arrow_back_ios),
                        Text(
                          "Create a labourer account ",
                          style: TextStyles.font18BlackW500,
                        ),
                        Gap(5.w),
                        SvgPicture.asset("assets/images/labourer_icon.svg"),
                      ],
                    ),
                  ),
                  Gap(11.h),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 45),

                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "Welcome ! \n",
                              style: TextStyles.font24PrimaryColorW800,
                            ),
                            TextSpan(text: "Create Account At ServiGo"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Gap(16.h),
                  SocialAuthButton(
                    title: "Continue with Google",
                    image: Assets.googleIcon,
                    onPressed: () {},
                  ),
                  Gap(20.h),
                  SocialAuthButton(
                    title: "Continue with apple",
                    image: Assets.appleIcon,
                    onPressed: () {},
                  ),
                  Gap(20.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OrDivider(),
                  ),
                  Gap(20.h),
                  Column(
                    children: [
                      CustomTextFormFiled(
                        validator: Validators.fullName,

                        hintText: 'Full Name',

                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: SvgPicture.asset(
                            "assets/images/name_icon.svg",
                          ),
                        ),
                        textInputType: TextInputType.name,
                      ),
                      Gap(20.h),
                      CustomTextFormFiled(
                        validator: Validators.phone,
                        hintText: 'Phone Number',

                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: SvgPicture.asset(
                            "assets/images/phone_icon.svg",
                          ),
                        ),
                        textInputType: TextInputType.number,
                      ),
                      Gap(20.h),
                      CustomTextFormFiled(
                        validator: Validators.email,
                        hintText: 'Email Address',

                        prefixIcon: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: SvgPicture.asset(
                            "assets/images/iconEmail.svg",
                          ),
                        ),
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 20.h),
                      GestureDetector(
                        onTap: () async {
                          final result = await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CustomLocation(),
                            ),
                          );

                          debugPrint("Result received: $result");

                          if (result != null && result is Map) {
                            // تأكد أن الـ widget لا يزال موجوداً
                            if (mounted) {
                              setState(() {
                                locationController.text = result['name'] ?? '';
                              });
                            }
                          }
                        },
                        child: AbsorbPointer(
                          child: CustomTextFormFiled(
                            controller: locationController,
                            hintText: 'Location',
                            readOnly: true,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(11.w),
                              child: SvgPicture.asset(
                                "assets/images/location_icon.svg",
                              ),
                            ),
                            textInputType: TextInputType.text,
                          ),
                        ),
                      ),
                      Gap(20.h),
                      CustomTextFormFiled(
                        hintText: "Choose The Service",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(11.w),
                          child: SvgPicture.asset(
                            "assets/images/iconservice.svg",
                          ),
                        ),
                        isDropdown: true,
                        value: selectedService,
                        items: ['Professional', 'Academic'],
                        onChanged: (value) {
                          setState(() {
                            selectedService = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select service";
                          }
                          return null;
                        },
                      ),

                      Gap(20.h),
                      CustomTextFormFiled(
                        hintText: "Region",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(11.w),
                          child: SvgPicture.asset(
                            "assets/images/region_icon.svg",
                          ),
                        ),
                        isDropdown: true,
                        value: selectedRegion,
                        items: ['Fixed', 'Variable'],
                        onChanged: (value) {
                          setState(() {
                            selectedRegion = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return "Please select region";
                          }
                          return null;
                        },
                      ),
                      Gap(20.h),
                      CustomTextFormFiled(
                        validator: Validators.password,
                        hintText: 'Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(11.w),
                          child: SvgPicture.asset(
                            "assets/images/password_icon.svg",
                          ),
                        ),
                        textInputType: TextInputType.number,
                      ),
                      Gap(20.h),
                      CustomTextFormFiled(
                        hintText: 'Confirm Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(11.w),
                          child: SvgPicture.asset(
                            "assets/images/password_icon.svg",
                          ),
                        ),
                        textInputType: TextInputType.number,
                      ),
                      Gap(25.h),
                      TermsAndConditionsWidget(onChanged: (bool value) {}),
                      Gap(56.h),
                      CustomButton(
                        title: "Sign up",
                        textstyle: TextStyles.font20White800,
                        width: MediaQuery.sizeOf(context).width * 0.88,
                        height: 52.h,
                        onTap: () {
                          GoRouter.of(
                            context,
                          ).pushReplacement(AppRouter.kVerviciton);
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
      ),
    );
  }
}
