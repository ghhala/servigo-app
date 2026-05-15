import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';

class SuccessPopUp extends StatelessWidget {
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.45),
      builder: (_) => const SuccessPopUp(),
    );
  }

  const SuccessPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        shadowColor: Colors.white.withOpacity(0.4),
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

              const Text(
                'S u c c e s s !',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4F6EF7),
                  letterSpacing: 2,
                ),
              ),

              Gap(12.h),

              const Text(
                'The account has been\ncreated successfully',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4F6EF7),
                  height: 1.6,
                ),
              ),

              Gap(32.h),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4F6EF7),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
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
