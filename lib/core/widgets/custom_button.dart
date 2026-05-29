import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  TextStyle? textstyle;
  final double? width;
  final double? height;
 final IconData? icon;

  final void Function()? onTap;
  CustomButton({
    super.key,
    required this.title,
    this.textstyle,
    this.width,
    this.height,
    this.icon,
    required this.onTap, 
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width * 0.48,
        height: height ?? MediaQuery.sizeOf(context).height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF472187), Color(0xFF06B6D4)],
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(title, style: textstyle ?? TextStyles.font30WhiteW600),
        //     Gap(16),
        //     Icon(icon, color: Colors.white),
        //   ],
        // ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: Text(
                title,
                style: textstyle ?? TextStyles.font26WhiteW600,
              ),
            ),
            Positioned(right: 24.w, child: Icon(icon, color: Colors.white)),

          ],
        ),
      ),
    );
  }
}
