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
import 'package:servi_go_app/core/localization/app_localizations.dart';

class LogIn extends StatelessWidget {
  final String userType;
  LogIn({super.key, required this.userType});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("The userType inside LogIn Screen is: $userType");
    return Scaffold(
      resizeToAvoidBottomInset: false,

      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back_ios),
                      Text(AppLocalizations.of(context)!.logIn,
                        style: TextStyles.font18BlackW500.copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  Gap(10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(context)!.welcomeBack,
                            style: TextStyles.font24PrimaryColorW800,
                          ),
                          TextSpan(text: AppLocalizations.of(context)!.loginWithAccount),
                        ],
                      ),
                    ),
                  ),
                  Gap(21.h),
                  SocialAuthButton(
                    image: Assets.googleIcon,
                    title: AppLocalizations.of(context)!.continueWithGoogle,
                    onPressed: () {},
                  ),
                  Gap(21.h),
                  SocialAuthButton(
                    image: Assets.appleIcon,
                    title: AppLocalizations.of(context)!.continueWithApple,
                    onPressed: () {},
                  ),
                  Gap(8.h),
                  OrDivider(),
                  Gap(16.h),
                  CustomTextFormFiled(
                    hintText: AppLocalizations.of(context)!.phoneNumber,
                    validator: Validators.phone,

                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: SvgPicture.asset("assets/images/phone_icon.svg"),
                    ),
                    textInputType: TextInputType.number,
                  ),
                  Gap(16.h),
                  CustomTextFormFiled(
                    hintText: AppLocalizations.of(context)!.password,
                    validator: Validators.password,

                    prefixIcon: Padding(
                      padding: EdgeInsets.all(11.w),
                      child: SvgPicture.asset(
                        "assets/images/password_icon.svg",
                      ),
                    ),
                    textInputType: TextInputType.text,
                  ),
                  Gap(10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kforgetPassword);
                      },
                      child: Text(
                        AppLocalizations.of(context)!.forgetPasswordQuestion,
                        style: TextStyles.font12GreyW400(context),
                      ),
                    ),
                  ),
                  Gap(46.h),
                  CustomButton(
                    title: AppLocalizations.of(context)!.logIn,
                    textstyle: TextStyles.font20White800,
                    width: MediaQuery.sizeOf(context).width * 0.88,
                    height: 52.h,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        GoRouter.of(
                          context,
                        ).go(AppRouter.kHome, extra: userType);
                      }
                    },
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.dontHaveAccount,
                        style: TextStyles.font16PrimaryColorW400.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          userType == 'labourer'
                              ? GoRouter.of(
                                  context,
                                ).push(AppRouter.kuserlabourer, extra: userType)
                              : GoRouter.of(
                                  context,
                                ).push(AppRouter.ksignupuser, extra: userType);
                        },
                        child: Text(AppLocalizations.of(context)!.signUp,
                          style: TextStyles.font16PrimaryColorW400.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
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
