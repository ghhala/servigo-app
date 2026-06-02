import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/Validators_widget.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/or_divider%20.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/social_auth_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/success_pop_up.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/terms_and_conditions_widget%20.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';

class SignUpUser extends StatelessWidget {
  final String userType;
  SignUpUser({super.key, required this.userType});
  final formKey = GlobalKey<FormState>();

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
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Text(
                        AppLocalizations.of(context)!.createUserAccount,
                        style: TextStyles.font18BlackW500,
                      ),
                      Gap(16.w),
                      SvgPicture.asset("assets/images/userIcon.svg"),
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
                            text: AppLocalizations.of(context)!.welcomeCreateAccount,
                            style: TextStyles.font24PrimaryColorW800,
                          ),
                          TextSpan(text: AppLocalizations.of(context)!.welcomeCreateAccount),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(16.h),
                SocialAuthButton(
                  title: AppLocalizations.of(context)!.continueWithGoogle,
                  image: Assets.googleIcon,
                  onPressed: () {},
                ),
                Gap(20.h),
                SocialAuthButton(
                  title: AppLocalizations.of(context)!.continueWithApple,
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
                      hintText: AppLocalizations.of(context)!.emailAddress,

                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset("assets/images/iconEmail.svg"),
                      ),
                      textInputType: TextInputType.emailAddress,
                    ),
                    Gap(20.h),

                    CustomTextFormFiled(
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
                      title: AppLocalizations.of(context)!.signUp,
                      textstyle: TextStyles.font20White800,
                      width: MediaQuery.sizeOf(context).width * 0.88,
                      height: 52.h,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          SuccessPopUp.show(context, userType);
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
