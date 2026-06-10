import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // مكتبة الـ Bloc للتحكم بالحالة
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart'; // 👈 استيراد مكتبة الـ GoRouter للانتقال للشاشات
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/data/models/register_user_request_body.dart'; // موديل الـ Request Body
import 'package:servi_go_app/features/auth/presentation/view_models/register_user/register_user_cubit.dart'; // الـ Cubit الجديد
import 'package:servi_go_app/features/auth/presentation/views/widgets/Validators_widget.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/or_divider%20.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/social_auth_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/terms_and_conditions_widget%20.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';

class SignUpUser extends StatefulWidget {
  final String userType;
  SignUpUser({super.key, required this.userType});

  @override
  State<SignUpUser> createState() => _SignUpUserState();
}

class _SignUpUserState extends State<SignUpUser> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AppBackground(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 42),
                  child: SvgPicture.asset(Assets.logo),
                ),
                Gap(28.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(), 
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      Text(
                        AppLocalizations.of(context)!.createUserAccount,
                        style: TextStyles.font18BlackW500,
                      ),
                      Gap(16.w),
                      SvgPicture.asset("assets/images/userIcon.svg"),
                    ],
                  ),
                ),
                Gap(11.h),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: AppLocalizations.of(
                              context,
                            )!.welcomeCreateAccount,
                            style: TextStyles.font24PrimaryColorW800,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(
                              context,
                            )!.welcomeCreateAccount,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Gap(16.h),
                SocialAuthButton(
                  title: AppLocalizations.of(context)!.continueWithGoogle,
                  image: Assets.googleIcon,
                  onPressed: () {},
                ),
                Gap(20.h),
                SocialAuthButton(
                  title: AppLocalizations.of(context)!.continueWithApple,
                  image: Assets.appleIcon,
                  onPressed: () {},
                ),
                Gap(20.h),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OrDivider(),
                ),
                Gap(20.h),
                Column(
                  children: [
                    CustomTextFormFiled(
                      validator: Validators.fullName,
                      controller: nameController,
                      hintText: AppLocalizations.of(context)!.fullName,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset("assets/images/name_icon.svg"),
                      ),
                      textInputType: TextInputType.name,
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      validator: Validators.phone,
                      controller: phoneController,
                      hintText: AppLocalizations.of(context)!.phoneNumber,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset("assets/images/phone_icon.svg"),
                      ),
                      textInputType: TextInputType.number,
                    ),
                    Gap(20.h),
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
                    Gap(20.h),

                    CustomTextFormFiled(
                      validator: Validators.password,
                      controller: passwordController,
                      hintText: AppLocalizations.of(context)!.password,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.w),
                        child: SvgPicture.asset(
                          "assets/images/password_icon.svg",
                        ),
                      ),
                      textInputType: TextInputType.text,
                    ),
                    Gap(20.h),
                    CustomTextFormFiled(
                      controller: confirmPasswordController,
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(11.w),
                        child: SvgPicture.asset(
                          "assets/images/password_icon.svg",
                        ),
                      ),
                      textInputType: TextInputType.text,
                    ),
                    Gap(25.h),
                    TermsAndConditionsWidget(onChanged: (bool value) {}),
                    Gap(56.h),

                    BlocConsumer<RegisterUserCubit, RegisterUserState>(
                      listener: (context, state) async {
                        if (state is RegisterUserSuccess) {
                          await PrefHelper.clearUserImage();
                          await PrefHelper.saveString('user_name', nameController.text.trim());
                          if (!context.mounted) return;

                          context.push(
                            AppRouter.kotpcode,
                            extra: {
                              'registerCubit': context
                                  .read<RegisterUserCubit>(),
                              'otp': '',
                              'email': emailController.text.trim(),
                              'userType': widget.userType,
                              'isForgetPassword': false,
                              'authAction': 'register',
                            },
                          );
                        }

                        if (state is RegisterUserFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.error.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is RegisterUserLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return CustomButton(
                          title: AppLocalizations.of(context)!.signUp,
                          textstyle: TextStyles.font20White800,
                          width: MediaQuery.sizeOf(context).width * 0.88,
                          height: 52.h,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              final signUpData = RegisterUserRequestBody(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                password: passwordController.text,
                                passwordConfirmation:
                                    confirmPasswordController.text,
                              );

                              context.read<RegisterUserCubit>().registerUser(
                                signUpData,
                              );
                            }
                          },
                        );
                      },
                    ),
                    Gap(30.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
