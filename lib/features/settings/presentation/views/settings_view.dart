import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/settings/presentation/widgets/custom_Row_widget.dart';

class SettingsView extends StatefulWidget {
 
  final bool isProvider; 

  const SettingsView({super.key, required this.isProvider,  });

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _isAvailable = false;
  bool _overnight = false; 

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
                  const Gap(20),
                  SvgPicture.asset("assets/images/setting_icon.svg"),
                ],
              ),
              const Gap(90),
              Container(
                width: 353.w,
                // 🚀 تعديل الارتفاع ديناميكياً ليناسب المحتوى حسب نوع الحساب ومنع الفراغات الزائدة
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
                        // ── العناصر المشتركة (تظهر لليوزر ولصاحب المهنة) ──
                        CustomRowWidget(
                          text: l10n.editProfile,
                          iconPath: 'assets/images/profile_icon.svg',
                        ),
                        CustomRowWidget(
                          text: l10n.logOut,
                          iconPath: 'assets/images/log_out_icon.svg',
                          style: TextStyles.font16PrimaryColorW600.copyWith(
                            color: const Color(0xFFFF0000),
                          ),
                        ),
                        CustomRowWidget(
                          text: l10n.deleteAccount,
                          iconPath: 'assets/images/delete_icon.svg',
                          style: TextStyles.font16PrimaryColorW600.copyWith(
                            color: const Color(0xFFFF0000),
                          ),
                        ),
                        CustomRowWidget(
                          text: l10n.visitWebsite, // أو لترجمتها لو مدعومة بالملف l10n.visitWebsite
                          iconPath: 'assets/images/visite_icon.svg',
                          style: TextStyles.font16PrimaryColorW600,
                        ),

                        // ── عناصر صاحب المهنة فقط (تظهر إذا كان isProvider == true) ──
                        if (widget.isProvider) ...[
                          CustomRowWidget(
                            text: 'Available Now',
                            iconPath: 'assets/images/checked.png', // تأكدي من امتداد الأيقونة لديكِ svg أم png
                            style: TextStyles.font16PrimaryColorW600,
                            trailing: CupertinoSwitch(
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.grey,
                              value: _isAvailable,
                              onChanged: (value) {
                                setState(() {
                                  _isAvailable = value;
                                });
                              },
                            ),
                          ),
                          CustomRowWidget(
                            text: 'Overnight Service',
                            iconPath: 'assets/images/setting_icon.svg', // يمكنك تغيير مسار الأيقونة للـ overnight هنا
                            style: TextStyles.font16PrimaryColorW600,
                            trailing: CupertinoSwitch(
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.grey,
                              value: _overnight,
                              onChanged: (value) {
                                setState(() {
                                  _overnight = value;
                                });
                              },
                            ),
                          ),
                        ],
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
    );
  }
}