import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class CustomTab extends StatelessWidget {
  final String title;
  final bool isSelected;

  const CustomTab({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.w,
      height: 27.h,
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFF093040)
            : const Color(0xFF093040).withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Center(
        child: Text(title, style: TextStyles.font11WhiteW500),
      ),
    );
  }
}