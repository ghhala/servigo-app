import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/success_password_pop_up.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/register_user/register_user_cubit.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/Validators_widget.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class ResetPasswordView extends StatefulWidget {
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
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _submitResetPassword() {
    if (!formKey.currentState!.validate()) return;

    final email = widget.userEmail?.trim() ?? '';
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email is missing'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<RegisterUserCubit>().resetPassword(
      email: email,
      password: passwordController.text.trim(),
      passwordConfirmation: confirmPasswordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 19.w),
          child: BlocConsumer<RegisterUserCubit, RegisterUserState>(
            listener: (context, state) {
              if (state is ResetPasswordSuccess) {
                SuccessPasswordPopUp.show(context);

                Future.delayed(const Duration(milliseconds: 300), () {
                  if (!context.mounted) return;
                  context.go(AppRouter.klogIn, extra: widget.userType);
                });
              }

              if (state is ResetPasswordFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              final bool isLoading = state is ResetPasswordLoading;

              return Form(
                key: formKey,
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
                          AppLocalizations.of(context)!.resetPassword,
                          style: TextStyles.font18BlackW500.copyWith(
                            fontSize: 20.sp,
                          ),
                        ),
                      ],
                    ),
                    Gap(5.h),
                    Center(
                      child: Image.asset(
                        "assets/images/login1.png",
                        width: 230.w,
                        height: 210.h,
                      ),
                    ),

                    Text(
                      AppLocalizations.of(context)!.pleaseEnterNewPassword,
                      style: TextStyles.font16PrimaryColorW400.copyWith(
                        fontSize: 13.sp,
                      ),
                    ),
                    Gap(20.h),

                    /// Password
                    CustomTextFormFiled(
                      controller: passwordController,
                      validator: Validators.password,
                      hintText: AppLocalizations.of(context)!.password,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(13.w),
                        child: SvgPicture.asset(
                          "assets/images/password_icon.svg",
                        ),
                      ),
                      textInputType: TextInputType.text,
                    ),

                    Gap(20.h),

                    /// Confirm Password
                    CustomTextFormFiled(
                      controller: confirmPasswordController,
                      validator: (value) => Validators.confirmPassword(
                        value,
                        passwordController.text,
                      ),
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(13.w),
                        child: SvgPicture.asset(
                          "assets/images/password_icon.svg",
                        ),
                      ),
                      textInputType: TextInputType.text,
                    ),

                    Gap(51.h),

                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF6C5CE7),
                        ),
                      )
                    else
                      CustomButton(
                        title: AppLocalizations.of(context)!.resetPassword,
                        textstyle: TextStyles.font20White800,
                        width: MediaQuery.sizeOf(context).width * 0.88,
                        height: 52.h,
                        onTap: _submitResetPassword,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
