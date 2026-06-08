import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/otp_files.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/success_pop_up.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/register_user/register_user_cubit.dart';

class OtpCodeView extends StatefulWidget {
  final String receivedOtp;
  final String userEmail;
  final String userType;
  final bool isForgetPassword;

  const OtpCodeView({
    super.key,
    required this.receivedOtp,
    required this.userEmail,
    required this.userType,
    required this.isForgetPassword,
  });

  @override
  State<OtpCodeView> createState() => _OtpCodeViewState();
}

class _OtpCodeViewState extends State<OtpCodeView> {
  String enteredOtp = "";

  void _handleNavigationOnSuccess() {
    if (widget.isForgetPassword) {
      context.go(
        AppRouter.kresetpassword,
        extra: {
          'otp': enteredOtp.isNotEmpty ? enteredOtp : widget.receivedOtp,
          'email': widget.userEmail,
          'userType': widget.userType,
        },
      );
    } else if (widget.userType == 'labourer' || widget.userType == 'provider') {
      context.go(
        AppRouter.kCompliteProfile,
        extra: {
          'userType': widget.userType,
          'userData': {'email': widget.userEmail},
        },
      );
    } else {
      SuccessPopUp.show(context, widget.userType, widget.userEmail);
    }
  }

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
                  GestureDetector(
                    onTap: () => context.pop(),
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
                      text: " ${widget.userEmail} ",
                      style: TextStyles.font16PrimaryColorW400.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
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
                  setState(() {
                    enteredOtp = value;
                  });
                },
              ),
              Gap(26.h),

              // 🛠️ تحديث الـ BlocConsumer للتحقق من حفظ الـ Token وتوجيه شاشة الـ Login
              BlocConsumer<RegisterUserCubit, RegisterUserState>(
                listener: (context, state) async {
                  if (state is VerifyOtpSuccess) {
                    if (!context.mounted) return;

                    // 💡 فحص ذكي: إذا كان المستخدم عادي (User) وليس في مسار نسيان كلمة المرور
                    // فهذا يعني أنه جاء من اللوجن أو التسجيل وجلب التوكن بنجاح، فيذهب للهوم مباشرة!
                    if (widget.userType == 'user' && !widget.isForgetPassword) {
                      context.go(AppRouter.kHome, extra: widget.userType);
                    } else {
                      // المسار الطبيعي لـ (Labourer ليرفع مستنداته) أو (ForgetPassword ليعيد تعيين كلمته)
                      _handleNavigationOnSuccess();
                    }
                  }
                  if (state is VerifyOtpFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is VerifyOtpLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFFB38CF5),
                        ),
                      ),
                    );
                  }

                  return CustomButton(
                    title: AppLocalizations.of(context)!.verifyCode,
                    textstyle: TextStyles.font20White800,
                    width: MediaQuery.sizeOf(context).width * 0.88,
                    height: 52.h,
                  
onTap: () {
  final codeToVerify = enteredOtp.isNotEmpty ? enteredOtp : widget.receivedOtp;

  if (codeToVerify.isNotEmpty) {
    // 💡 تحديد الـ type ديناميكياً
    // إذا كان ForgetPassword نرسل 'forget'، وإلا نرسل الـ userType القادم (أو تحديداً 'login' / 'register' حسب الباكيند)
    // بناءً على البوست مان، الباكيند يتوقع 'login' في حالة اللوجن، دعينا نمرر الـ flow الصحيح:
    final String currentType = widget.isForgetPassword ? 'forget' : 'login'; 
    // ملاحظة: إذا كانت الشاشة تُستخدم للتسجيل أيضاً، يمكنكِ جعل التحديد أكثر دقة بناءً على الحاجة.

    context.read<RegisterUserCubit>().verifyOtp(
      email: widget.userEmail,
      otp: codeToVerify,
      type: currentType, 
    );
  } else {
   
  }
}
                  );
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