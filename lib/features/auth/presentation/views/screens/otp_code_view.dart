import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/otp_files.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';

class OtpCodeView extends StatelessWidget {
  final String receivedOtp;
  final String userEmail;
  const OtpCodeView({
    super.key,
    required this.receivedOtp,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    String enteredOtp = "";

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
                    AppLocalizations.of(context)!.otpCode,
                    style: TextStyles.font18BlackW500.copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
              Gap(41.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.otpCode,
                  style: TextStyles.font22PrimaryColorW700,
                ),
              ),
              Gap(12.h),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: AppLocalizations.of(context)!.pleaseEnterOtp,
                      style: TextStyles.font16PrimaryColorW400.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                    TextSpan(
                      text: userEmail,
                      style: TextStyles.font16PrimaryColorW400.copyWith(
                        fontSize: 12.sp,
                      ),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context)!.changeIt,
                      style: TextStyles.font16PrimaryColorW400.copyWith(
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(21.h),
              OtpFields(
                onCompleted: (value) {
                  enteredOtp =
                      value; // سيتم تحديث هذه القيمة تلقائياً كلما كتب المستخدم حرفاً
                },
              ),
              Gap(26.h),
              CustomButton(
                title: AppLocalizations.of(context)!.verifyCode,
                textstyle: TextStyles.font20White800,
                width: MediaQuery.sizeOf(context).width * 0.88,
                height: 52.h,
                onTap: () {
                  if (enteredOtp == receivedOtp) {
                    context.go(
  AppRouter.kresetpassword,
  extra: {
    'otp': receivedOtp,
    'email': userEmail,
    'userType': 'user', // أو القيمة الديناميكية المتوفرة لديك
  },
);
                  } else {
                    // إظهار خطأ
                  }
                },
              ),
              Gap(16.h),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.resendCode,
                    style: TextStyles.font12GreyW400(context),
                  ),
                  Spacer(),
                  Text(
                    AppLocalizations.of(context)!.resendIn,
                    style: TextStyles.font16PrimaryColorW400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
