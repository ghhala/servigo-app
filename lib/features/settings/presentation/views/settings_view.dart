import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/screens/edite_profile_provider.dart';
import 'package:servi_go_app/features/settings/presentation/view_models/settings/settings_cubit.dart';
import 'package:servi_go_app/features/settings/presentation/view_models/settings/settings_state.dart';
import 'package:servi_go_app/features/settings/presentation/widgets/custom_Row_widget.dart';
import 'package:servi_go_app/features/user_profile/data/models/user_profile_model.dart';

class SettingsView extends StatefulWidget {
  final bool isProvider;

  const SettingsView({super.key, required this.isProvider});

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

      child: Scaffold(
        body: AppBackground(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      l10n.settings,
                      style: TextStyles.font22PrimaryColorW700.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Gap(20),
                    SvgPicture.asset("assets/images/setting_icon.svg"),
                  ],
                ),
                const Gap(70),
                Container(
                  width: 353.w,
                
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 10.r,
                        offset: Offset(0, 5.h),
                      ),
                    ],
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                   CustomRowWidget(
  text: l10n.editProfile,
  iconPath: 'assets/images/profile_icon.svg',
  onTap: () async {
    if (widget.isProvider) {
     
      final currentCubit = context.read<ProviderProfileCubit>();

      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: currentCubit,
            child: const EditProfileProviderView(),
          ),
        ),
      );

     
      if (result == true && context.mounted) {
        currentCubit.fetchProviderProfile();
      }
    } else {
  final userProfileData = UserProfileData(
    name: PrefHelper.getString('user_name'),
    phone: PrefHelper.getString('user_phone'),
    photo: PrefHelper.getUserImage().isNotEmpty
        ? PrefHelper.getUserImage()
        : null,
  );

  context.push(
    AppRouter.kEditeProfile,
    extra: userProfileData,
  );
}
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

                          showDivider: (widget.isProvider) ? true : false,
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
                                    iconPath: 'assets/images/night-mode.png',
                                    style: TextStyles.font16PrimaryColorW600,
                                    showDivider: false,
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
                const Gap(25),
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
            child: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
