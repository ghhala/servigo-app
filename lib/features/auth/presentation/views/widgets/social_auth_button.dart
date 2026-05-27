import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class SocialAuthButton extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onPressed;
  final double? height;
  final double? width;

  const SocialAuthButton({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color onSurface = Theme.of(context).colorScheme.onSurface;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width ?? MediaQuery.of(context).size.width * 0.88,
        height: height ?? 47.h,
        decoration: BoxDecoration(
          border: Border.all(
            color: isDark ? onSurface.withOpacity(0.6) : Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 7, offset: Offset(0, 1)),
          ],
          color: Theme.of(context).cardColor,
        ),
        // child: MaterialButton(
        //   onPressed: onPressed,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,

        //     children: [
        //       SvgPicture.asset(image),
        //       Gap(16.w),
        //       Text(title, style: TextStyles.font16PrimaryColorW400),
        //     ],
        //   ),
        // ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            Gap(16.w),
            Text(
              title,
              style: TextStyles.onCard(context, TextStyles.font16PrimaryColorW400),
            ),
          ],
        ),
      ),
    );
  }
}
