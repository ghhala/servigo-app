import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class ContainerWidget extends StatelessWidget {
  final String text;
  final String image;
  final num? number;
  const ContainerWidget({
    super.key,
    required this.text,
    required this.image,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 48.h,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 4.0, top: 7),
        child: Row(
          children: [
            Image.asset(image, width: 30),
            Gap(5),
            Column(
              children: [
                Text(
                  text,
                  style: TextStyles.onCard(
                    context,
                    TextStyles.font16BlackW700.copyWith(fontSize: 13.sp),
                  ),
                ),
                Text(
                  number?.toString() ?? "",
                  style: TextStyles.onCard(context, TextStyles.font11BlackW400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
