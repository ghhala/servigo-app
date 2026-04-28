import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(thickness: 1.7, color: Colors.black)),
        Gap(16.w),
        Text(
          'OR',
          textAlign: TextAlign.center,
          style: TextStyles.font16BlackW700,
        ),
        Gap(18.w),

        const Expanded(child: Divider(thickness: 1.7, color: Colors.black)),
      ],
    );
  }
}
