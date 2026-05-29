import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      height: 74.h,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, l10n.home),
          _buildNavItem(1, Icons.person_pin_circle_rounded, l10n.profile),
          _buildNavItem(2, Icons.message_rounded, l10n.messages),
          _buildNavItem(3, Icons.settings_rounded, l10n.settings),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF7A40F2) : Colors.transparent,
              borderRadius: BorderRadius.circular(15.r),
              gradient: isSelected
                  ? const LinearGradient(
                      colors: [Color(0xFF7A40F2), Color(0xFF9E72F9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : const Color(0xFF002B4B),
              size: 26.sp,
            ),
          ),
          Gap(4.h),
          Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? const Color(0xFF7A40F2)
                  : const Color(0xFF002B4B),
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
