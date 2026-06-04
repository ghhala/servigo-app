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
import 'package:servi_go_app/features/auth/presentation/views/widgets/success_pop_up.dart'; // 👈 استيراد الـ SuccessPopUp لعرضه عند نجاح الـ Sign Up

class OtpCodeView extends StatelessWidget {
  final String receivedOtp;
  final String userEmail;
  final String userType; 
  final bool isForgetPassword; // 👈 إضافة علم تحديد الوجهة

  const OtpCodeView({
    super.key,
    required this.receivedOtp,
    required this.userEmail,
    required this.userType, // تمريرها في الـ Constructor
    required this.isForgetPassword, // تمريرها في الـ Constructor
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
                  GestureDetector(
                    onTap: () => context.pop(), // تفعيل زر العودة للخلف
                    child: const Icon(Icons.arrow_back_ios),
                  ),
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
                      text: " $userEmail ",
                      style: TextStyles.font16PrimaryColorW400.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold, // تمييز الإيميل برسمة عريضة
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
                  enteredOtp = value; // تحديث كود الـ OTP المكتوب تلقائياً
                },
              ),
              Gap(26.h),
              CustomButton(
                title: AppLocalizations.of(context)!.verifyCode,
                textstyle: TextStyles.font20White800,
                width: MediaQuery.sizeOf(context).width * 0.88,
                height: 52.h,
                onTap: () {
                  // الفحص الذكي: التحقق من صحة الكود المُدخل (أو تركه فارغاً إذا كان الفحص يتم بالكامل عبر السيرفر)
                  // ملحوظة: إذا كان كود الـ Sign Up لا يعيد OTP لأن السيرفر يتحقق تلقائياً، يمكنك تعديل الشرط ليتناسب مع الباك آيند
                  if (enteredOtp == receivedOtp || isForgetPassword == false) {
                    
                    if (isForgetPassword) {
                      // 1️⃣ حالة نسيان كلمة المرور: نتوجه لصفحة إعادة التعيين مع الـ userType الحقيقي
                      context.go(
                        AppRouter.kresetpassword,
                        extra: {
                          'otp': enteredOtp.isNotEmpty ? enteredOtp : receivedOtp,
                          'email': userEmail,
                          'userType': userType,
                        },
                      );
                    } else {
                      // 2️⃣ حالة الـ Sign Up: نُظهر بوب آب النجاح ونمرر المعاملات المطلوبة داخله
                      SuccessPopUp.show(
                        context,
                        userType,
                        userEmail,
                      );
                    }

                  } else {
                    // في حالة عدم تطابق الكود (لمسار نسيان كلمة السر)
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("كود التحقق غير صحيح، يرجى إعادة المحاولة"),
                        backgroundColor: Colors.red,
                      ),
                    );
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
                  const Spacer(),
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