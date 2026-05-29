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
  final Widget? trailing;
  const CustomRowWidget({
    super.key,
    required this.text,
    required this.iconPath,
    this.style,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = style ?? TextStyles.font16PrimaryColorW600;
    final TextStyle resolvedStyle = TextStyles.onCard(context, baseStyle);
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Gap(20),
              iconPath.endsWith('.svg')
                  ? SvgPicture.asset(iconPath)
                  : Image.asset(iconPath, width: 30.w),
              Gap(20),
              Text(text, style: resolvedStyle),
              Spacer(),
              trailing ??
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
