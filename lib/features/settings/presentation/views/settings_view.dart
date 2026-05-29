import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/localization/locale_cubit.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/settings/presentation/widgets/custom_Row_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.settings, style: TextStyles.font22PrimaryColorW700),
                  Gap(20),
                  SvgPicture.asset("assets/images/setting_icon.svg"),
                ],
              ),
              Gap(90),
              Container(
                width: 353.w,
                height: 300.h,
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
                          text: l10n.profile,
                          iconPath: 'assets/images/profile_icon.svg',
                        ),
                        CustomRowWidget(
                          text: l10n.editProfile,
                          iconPath: 'assets/images/profile_icon.svg',
                        ),
                        CustomRowWidget(
                          text: l10n.logOut,
                          iconPath: 'assets/images/log_out_icon.svg',
                          style: TextStyles.font16PrimaryColorW600.copyWith(
                            color: Color(0xFFFF0000),
                          ),
                        ),
                        CustomRowWidget(
                          text: l10n.deleteAccount,
                          iconPath: 'assets/images/delete_icon.svg',
                          style: TextStyles.font16PrimaryColorW600.copyWith(
                            color: Color(0xFFFF0000),
                          ),
                        ),
                        CustomRowWidget(
                          text: l10n.visitWebsite,
                          iconPath: 'assets/images/visite_icon.svg',
                          style: TextStyles.font16PrimaryColorW600,
                        ),
                        CustomRowWidget(
                          text: l10n.contactSupport,
                          iconPath: 'assets/images/support_icon.svg',
                          style: TextStyles.font16PrimaryColorW600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              ElevatedButton(
                onPressed: () => context.read<LocaleCubit>().toggleLocale(),
                child: Text(l10n.changeLanguage),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
