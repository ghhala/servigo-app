import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text(
                    "Reset password",
                    style: TextStyles.font18BlackW500.copyWith(fontSize: 20.sp),
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
                hintText: 'Password',

                prefixIcon: Padding(
                  padding: EdgeInsets.all(13.w),
                  child: SvgPicture.asset("assets/images/password_icon.svg"),
                ),
                textInputType: TextInputType.number,
              ),
              Gap(20.h),
              CustomTextFormFiled(
                hintText: ' Confirm Password',

                prefixIcon: Padding(
                  padding: EdgeInsets.all(13.w),
                  child: SvgPicture.asset("assets/images/password_icon.svg"),
                ),
                textInputType: TextInputType.number,
              ),
              Gap(51.h),
              CustomButton(
                title: "Reset Password",
                textstyle: TextStyles.font20White800,
                width: MediaQuery.sizeOf(context).width * 0.88,
                height: 52.h,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
