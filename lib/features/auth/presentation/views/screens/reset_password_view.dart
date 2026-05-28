import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/success_password_pop_up.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/Validators_widget.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class ResetPasswordView extends StatelessWidget {
  final String userType;
  final String? receivedOtp;
  final String? userEmail;

  const ResetPasswordView({
    super.key,
    required this.userType,
    this.receivedOtp,
    this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.arrow_back_ios),
                    Text(
                      "Reset password",
                      style: TextStyles.font18BlackW500.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                Gap(41.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Reset Password",
                    style: TextStyles.font22PrimaryColorW700,
                  ),
                ),
                Gap(12.h),
                Text(
                  "Please Enter New Password And Try Don't Forget it ",
                  style: TextStyles.font16PrimaryColorW400.copyWith(
                    fontSize: 13.sp,
                  ),
                ),
                Gap(20.h),
                CustomTextFormFiled(
                  controller: passwordController,
                  validator: Validators.password,
                  hintText: 'Password',

                  prefixIcon: Padding(
                    padding: EdgeInsets.all(13.w),
                    child: SvgPicture.asset("assets/images/password_icon.svg"),
                  ),
                  textInputType: TextInputType.text,
                ),
                Gap(20.h),
                CustomTextFormFiled(
                  controller: confirmPasswordController,
                  validator: (confirmPasswordController) =>
                      Validators.confirmPassword(
                        confirmPasswordController,
                        passwordController.text,
                      ),
                  hintText: ' Confirm Password',

                  prefixIcon: Padding(
                    padding: EdgeInsets.all(13.w),
                    child: SvgPicture.asset("assets/images/password_icon.svg"),
                  ),
                  textInputType: TextInputType.text,
                ),
                Gap(51.h),
                CustomButton(
                  title: "Reset Password",
                  textstyle: TextStyles.font20White800,
                  width: MediaQuery.sizeOf(context).width * 0.88,
                  height: 52.h,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      SuccessPasswordPopUp.show(context);
                      GoRouter.of(
                        context,
                      ).push(AppRouter.klogIn, extra: userType);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
