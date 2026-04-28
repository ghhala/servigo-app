import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class CustomTab extends StatelessWidget {
  final String title;
  const CustomTab({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.w,
      height: 27.h,
      decoration: BoxDecoration(
        color: Color(0xFF093040),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
      ),
      child: Center(child: Text(title, style: TextStyles.font11WhiteW500)),
    );
  }
}
