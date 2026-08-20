import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/open_admin_chat.dart';
import 'package:servi_go_app/core/widgets/waiting_approval_dialog.dart';
import 'package:servi_go_app/core/widgets/account_rejected_dialog.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/register_user/register_user_cubit.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/otp_files.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/success_pop_up.dart';

class OtpCodeView extends StatefulWidget {
  final String? receivedOtp;
  final String userEmail;
  final String userType;
  final bool isForgetPassword;
  final String? authAction;
  final int? mainServiceId;

  const OtpCodeView({
    super.key,
    this.receivedOtp,
    required this.userEmail,
    required this.userType,
    required this.isForgetPassword,
    this.authAction,
    this.mainServiceId,
  });

  @override
  State<OtpCodeView> createState() => _OtpCodeViewState();
}

class _OtpCodeViewState extends State<OtpCodeView> {
  String enteredOtp = "";

  static const int _resendDuration = 60;
  int _secondsLeft = _resendDuration;
  Timer? _timer;

  late final TapGestureRecognizer _changeEmailRecognizer;

  bool get isDeleteAccountFlow => widget.authAction == 'delete_account';

  @override
  void initState() {
    super.initState();
    _startTimer();
    _changeEmailRecognizer = TapGestureRecognizer()
      ..onTap = () {
        if (context.canPop()) {
          context.pop();
        }
      };
  }

  @override
  void dispose() {
    _timer?.cancel();
    _changeEmailRecognizer.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = _resendDuration;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;

      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });

    if (mounted) {
      setState(() {});
    }
  }

  String _resolveCurrentType() {
    if (isDeleteAccountFlow) {
      return 'delete_account';
    } else if (widget.isForgetPassword) {
      return 'forgot_password';
    } else if (widget.authAction != null && widget.authAction!.isNotEmpty) {
      return widget.authAction!;
    } else {
      return 'register';
    }
  }

  void _handleNavigationOnSuccess(Map<String, dynamic> data) {
    if (isDeleteAccountFlow) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account delete susseccfily '),
          backgroundColor: Colors.green,
        ),
      );
      context.go(AppRouter.kusertypeview);
      return;
    }

    if (widget.isForgetPassword) {
      context.go(
        AppRouter.kresetpassword,
        extra: {
          'otp': enteredOtp,
          'email': widget.userEmail,
          'userType': widget.userType,
        },
      );
      return;
    }

    if (widget.userType == 'labourer' || widget.userType == 'provider') {
      if (widget.authAction == 'login') {
        final String status = (data['status'] ?? '').toString().toLowerCase();
        final bool profileCompleted = data['profile_completed'] == true;

        if (status == 'pending') {
          WaitingApprovalDialog.show(context);
          return;
        }
      if (status == 'rejected') {
  AccountRejectedDialog.show(
    context,
    rejectionReason: (data['rejection_reason'] as String?) ??
        'The request has been rejected by the administration',
    onContactAdmin: () => openAdminChat(context),
  );
  return;
}

        if (profileCompleted) {
          context.go(AppRouter.kHome, extra: {'userType': widget.userType});
        } else {
          context.go(
            AppRouter.kmoveToComplite,
            extra: {
              'userType': widget.userType,
              'userData': {
                'email': widget.userEmail,
                'main_service_id': widget.mainServiceId,
              },
            },
          );
        }
      } else {
        WaitingApprovalDialog.show(
          context,
          onOk: () {
            context.go(AppRouter.klogIn, extra: widget.userType);
          },
        );
      }
      return;
    }

    SuccessPopUp.show(context, widget.userType, widget.userEmail);
  }

  void _verifyCode() {
    final codeToVerify = enteredOtp.trim();

    if (codeToVerify.isEmpty || codeToVerify.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرجاء إدخال رمز التحقق كاملاً'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<RegisterUserCubit>().verifyOtp(
      email: widget.userEmail,
      otp: codeToVerify,
      type: _resolveCurrentType(),
      userType: widget.userType,
    );
  }

  void _resendCode() {
    context.read<RegisterUserCubit>().resendOtp(
      email: widget.userEmail,
      type: _resolveCurrentType(),
    );
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
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: _changeEmailRecognizer,
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/images/otp_view_photo.png",
                width: 300,
                height: 250,
              ),

              OtpFields(
                onCompleted: (value) {
                  enteredOtp = value;
                },
              ),

              Gap(26.h),

              BlocConsumer<RegisterUserCubit, RegisterUserState>(
                listener: (context, state) {
                  if (state is VerifyOtpSuccess) {
                    if (!context.mounted) return;

                    final response = state.result as Map<String, dynamic>?;
                    final data =
                        (response?['data'] as Map<String, dynamic>?) ?? {};

                    if (widget.userType == 'user' &&
                        !widget.isForgetPassword &&
                        !isDeleteAccountFlow) {
                      context.go(AppRouter.kHome, extra: widget.userType);
                    } else {
                      _handleNavigationOnSuccess(data);
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

                  if (state is ResendOtpSuccess) {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تم إرسال رمز جديد بنجاح'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    _startTimer();
                  }

                  if (state is ResendOtpFailure) {
                    if (!context.mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final bool isVerifying = state is VerifyOtpLoading;

                  return CustomButton(
                    title: isVerifying
                        ? "Verifying..."
                        : AppLocalizations.of(context)!.verifyCode,
                    textstyle: TextStyles.font20White800,
                    width: MediaQuery.sizeOf(context).width * 0.88,
                    height: 52.h,
                    onTap: isVerifying ? null : _verifyCode,
                  );
                },
              ),

              Gap(16.h),

              BlocBuilder<RegisterUserCubit, RegisterUserState>(
                builder: (context, state) {
                  final bool canResend = _secondsLeft == 0;
                  final bool isResending = state is ResendOtpLoading;

                  return Row(
                    children: [
                      GestureDetector(
                        onTap: (canResend && !isResending) ? _resendCode : null,
                        child: Text(
                          AppLocalizations.of(context)!.resendCode,
                          style: TextStyles.font12GreyW400(context).copyWith(
                            color: canResend ? null : Colors.grey,
                            decoration: canResend
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (isResending)
                        SizedBox(
                          width: 14.w,
                          height: 14.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      else if (canResend)
                        Text(
                          AppLocalizations.of(context)!.resendCode,
                          style: TextStyles.font16PrimaryColorW400,
                        )
                      else
                        Text(
                          "${AppLocalizations.of(context)!.resendIn} 00:${_secondsLeft.toString().padLeft(2, '0')} s",
                          style: TextStyles.font16PrimaryColorW400,
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}