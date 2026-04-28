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

class LogIn extends StatelessWidget {
  LogIn({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        "Log In",
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
                            text: "Welcome back! \n",
                            style: TextStyles.font24PrimaryColorW800,
                          ),
                          TextSpan(text: "Login With Your Account"),
                        ],
                      ),
                    ),
                  ),
                  Gap(21.h),
                  SocialAuthButton(
                    image: Assets.googleIcon,
                    title: 'Continue with Google',
                    onPressed: () {},
                  ),
                  Gap(21.h),
                  SocialAuthButton(
                    image: Assets.appleIcon,
                    title: 'Continue with apple',
                    onPressed: () {},
                  ),
                  Gap(8.h),
                  OrDivider(),
                  Gap(16.h),
                  CustomTextFormFiled(
                    hintText: 'Phone Number',
                    validator:Validators.phone,

                    prefixIcon: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: SvgPicture.asset("assets/images/phone_icon.svg"),
                    ),
                    textInputType: TextInputType.number,
                  ),
                  Gap(16.h),
                  CustomTextFormFiled(
                    
                    hintText: 'Password',
                    validator:Validators.password,

                    prefixIcon: Padding(
                      padding: EdgeInsets.all(11.w),
                      child: SvgPicture.asset(
                        "assets/images/password_icon.svg",
                      ),
                    ),
                    textInputType: TextInputType.number,
                  ),
                  Gap(10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        GoRouter.of(context).push(AppRouter.kforgetPassword);
                      },
                      child: Text(
                        "Forget Password?",
                        style: TextStyles.font12GreyW400(context),
                      ),
                    ),
                  ),
                  Gap(46.h),
                  CustomButton(
                    title: "Log In",
                    textstyle: TextStyles.font20White800,
                    width: MediaQuery.sizeOf(context).width * 0.88,
                    height: 52.h,
                    onTap: () {
                      if (formKey.currentState!.validate()) {}
                    },
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyles.font16PrimaryColorW400.copyWith(
                          fontSize: 14,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Sign Up",
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
