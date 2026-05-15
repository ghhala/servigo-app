import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Container(
        width: 360.w,
        decoration: BoxDecoration(
          color: Color(0xffAC83F4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              "ServiGo Terms and Conditions of Use\nBy using the ServiGo platform (as\na service provider or customer),\nyou agree to the following terms: ",
          style: TextStyles.font12BlackW400 ),
          ],
        ),
      ),
    );
  }
}
