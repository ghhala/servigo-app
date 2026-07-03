import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/view_models/register_user/register_user_cubit.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/Validators_widget.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String _extractErrorMessage(ApiError error) {
    if (error.message != null && error.message!.trim().isNotEmpty) {
      return error.message!;
    }
    return "failed to send verification code. Please try again.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<RegisterUserCubit, RegisterUserState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("successfully sent verification code to your email"),
                backgroundColor: Colors.green,
              ),
            );

            GoRouter.of(context).pushReplacement(
              AppRouter.kotpcode,
              extra: {
                'email': state.email,
                'userType': 'user',
                'isForgetPassword': true,
                'authAction': 'forgot_password',
              },
            );
          }

          if (state is ForgotPasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_extractErrorMessage(state.error)),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final bool isLoading = state is ForgotPasswordLoading;

          return AppBackground(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 19.w),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
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
                      title: isLoading
                          ? "Sending..."
                          : AppLocalizations.of(context)!.send,
                      textstyle: TextStyles.font20White800,
                      width: MediaQuery.sizeOf(context).width * 0.88,
                      height: 52.h,
                      onTap: isLoading
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) return;

                              await context
                                  .read<RegisterUserCubit>()
                                  .forgotPassword(
                                    email: emailController.text.trim(),
                                  );
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}