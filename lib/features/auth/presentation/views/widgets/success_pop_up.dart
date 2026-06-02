import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';

class SuccessPopUp extends StatelessWidget {
  static Future<void> show(BuildContext context,String userType) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) =>  SuccessPopUp(userType: userType),
    );
  }
final String userType;
  const SuccessPopUp({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color onSurface = Theme.of(context).colorScheme.onSurface;
    return AppBackground(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Theme.of(context).cardColor,
        shadowColor: Theme.of(context).shadowColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 50.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80.w,
                height: 80.h,
                decoration: const BoxDecoration(
                  color: Color(0xFF4F6EF7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 42),
              ),

              Gap(24.h),

              Text(
                AppLocalizations.of(context)!.success,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: isDark ? onSurface : const Color(0xFF4F6EF7),
                  letterSpacing: 2,
                ),
              ),

              Gap(12.h),

              Text(
                AppLocalizations.of(context)!.accountCreatedSuccessfully,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? onSurface : const Color(0xFF4F6EF7),
                  height: 1.6,
                ),
              ),

              Gap(32.h),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    GoRouter.of(context).push(AppRouter.kHome, extra: userType);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F6EF7),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.ok,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
