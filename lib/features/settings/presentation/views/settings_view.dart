import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart'; // ✅ أضف هذا
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/settings/presentation/view_models/settings/settings_cubit.dart';
import 'package:servi_go_app/features/settings/presentation/view_models/settings/settings_state.dart';
import 'package:servi_go_app/features/settings/presentation/widgets/custom_Row_widget.dart';

class SettingsView extends StatefulWidget {
  final bool isProvider;

  // ✅ احذف userEmail من هنا
  const SettingsView({
    super.key,
    required this.isProvider,
  });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.status == SettingsStatus.error &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }

        if (state.isLoggedOut) {
          context.go(AppRouter.kusertypeview);
        }

      
        if (state.otpSentForDeletion) {
          final email = PrefHelper.getEmail() ?? ''; 
          context.push(
            AppRouter.kOtpVerification,
            extra: {
              'otp': '',
              'email': email, 
              'userType': widget.isProvider ? 'labourer' : 'user',
              'isForgetPassword': false,
              'authAction': 'delete_account',
            },
          );
        }

        if (state.isAccountDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Account deleted successfully'),
              backgroundColor: Colors.green,
            ),
          );
          context.go(AppRouter.kusertypeview);
        }
      },

      // ── باقي الكود كما هو بدون تغيير ──
      child: Scaffold(
        body: AppBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.settings, style: TextStyles.font22PrimaryColorW700),
                    const Gap(20),
                    SvgPicture.asset("assets/images/setting_icon.svg"),
                  ],
                ),
                const Gap(90),
                Container(
                  width: 353.w,
                  height: widget.isProvider ? 390.h : 260.h,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10.r,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomRowWidget(
                            text: l10n.editProfile,
                            iconPath: 'assets/images/profile_icon.svg',
                            onTap: () {
                              Navigator.pushNamed(context, '/edit_profile');
                            },
                          ),
                          CustomRowWidget(
                            text: l10n.logOut,
                            iconPath: 'assets/images/log_out_icon.svg',
                            style: TextStyles.font16PrimaryColorW600.copyWith(
                              color: const Color(0xFFFF0000),
                            ),
                            onTap: () => _confirmLogout(context),
                          ),
                          CustomRowWidget(
                            text: l10n.deleteAccount,
                            iconPath: 'assets/images/delete_icon.svg',
                            style: TextStyles.font16PrimaryColorW600.copyWith(
                              color: const Color(0xFFFF0000),
                            ),
                            onTap: () => _confirmDeleteAccount(context),
                          ),
                          CustomRowWidget(
                            text: l10n.visitWebsite,
                            iconPath: 'assets/images/visite_icon.svg',
                            style: TextStyles.font16PrimaryColorW600,
                            onTap: () {},
                          ),
                          if (widget.isProvider)
                            BlocBuilder<SettingsCubit, SettingsState>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    CustomRowWidget(
                                      text: 'Available Now',
                                      iconPath: 'assets/images/checked.png',
                                      style: TextStyles.font16PrimaryColorW600,
                                      trailing: CupertinoSwitch(
                                        activeColor: Colors.green,
                                        inactiveThumbColor: Colors.grey,
                                        value: state.isAvailable,
                                        onChanged: (value) => context
                                            .read<SettingsCubit>()
                                            .toggleAvailability(value),
                                      ),
                                    ),
                                    CustomRowWidget(
                                      text: 'Overnight Service',
                                      iconPath: 'assets/images/setting_icon.svg',
                                      style: TextStyles.font16PrimaryColorW600,
                                      trailing: CupertinoSwitch(
                                        activeColor: Colors.green,
                                        inactiveThumbColor: Colors.grey,
                                        value: state.overnight,
                                        onChanged: (value) => context
                                            .read<SettingsCubit>()
                                            .toggleOvernight(value),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<SettingsCubit>().logout();
            },
            child: const Text('Log out', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteAccount(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<SettingsCubit>().deleteAccount();
            },
            child: const Text('Delete Account',
                style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}