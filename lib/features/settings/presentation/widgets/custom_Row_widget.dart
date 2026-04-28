import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class CustomRowWidget extends StatelessWidget {
  final String text;
  final String iconPath;
  final TextStyle? style;
  final void Function()? onTap;
  const CustomRowWidget({
    super.key,
    required this.text,
    required this.iconPath,
    this.style,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(6),
          child: Row(
            children: [
              Gap(20),
              SvgPicture.asset(iconPath),
              Gap(20),
              Text(text, style: style ?? TextStyles.font16PrimaryColorW600),
              Spacer(),
              GestureDetector(
                onTap: () {
                  onTap;
                },
                child: Icon(Icons.arrow_forward_ios, size: 16.sp),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
