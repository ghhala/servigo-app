import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/auth_view_model.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/Validators_widget.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final authVM = Provider.of<AuthViewModel>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(), // تفعيل زر العودة للخلف بأمان
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                    Text(
                      AppLocalizations.of(context)!.forgetPassword,
                      style: TextStyles.font18BlackW500.copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
                Gap(54.h),
                Text(
                  AppLocalizations.of(context)!.itsHappened,
                  style: TextStyles.font22PrimaryColorW700,
                ),
                Gap(12.h),
                Text(
                  AppLocalizations.of(context)!.pleaseSendCode,
                  style: TextStyles.font16PrimaryColorW400.copyWith(
                    fontSize: 13.sp,
                  ),
                ),
                Gap(50.h),
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
                Gap(43.h),
                CustomButton(
                  title: AppLocalizations.of(context)!.send,
                  textstyle: TextStyles.font20White800,
                  width: MediaQuery.sizeOf(context).width * 0.88,
                  height: 52.h,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      // 1. إرسال الرمز عبر الـ ViewModel وتحديث الـ userType من السيرفر
                      bool isSent = await authVM.sendOtpToUser(
                        emailController.text.trim(),
                      );

                      if (isSent) {
                        if (!context.mounted) return; // حماية السياق (Context Guard)

                        // 2. الانتقال إلى شاشة الـ OTP مع تمرير المعاملات الجديدة بالكامل
                        GoRouter.of(context).pushReplacement(
                          AppRouter.kotpcode,
                          extra: {
                            'otp': authVM.generatedOtp,
                            'email': emailController.text.trim(),
                           
                            'isForgetPassword': true,         
                          },
                        );
                      } else {
                        if (!context.mounted) return;
                        // 3. الفشل: إظهار رسالة خطأ للمخدم
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "فشل إرسال رمز التحقق، يرجى المحاولة لاحقاً",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
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