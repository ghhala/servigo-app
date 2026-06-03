import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';

class OnBoardingView2 extends StatelessWidget {
  const OnBoardingView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              child: SvgPicture.asset(Assets.logo),
            ),
            Gap(36.h),
            Image.asset('assets/images/on_boarding_view2.png'),
            Gap(16.h),
            Text(
              AppLocalizations.of(context)!.onBoardingDescription2,
              style: TextStyles.font19w500,
            ),
            Gap(54.h),

            CustomButton(
              title: AppLocalizations.of(context)!.getStarted,
              textstyle: TextStyles.font26WhiteW600,
              width: 250.w,
              onTap: () {
                GoRouter.of(context).pushReplacement(AppRouter.kusertypeview);
              },
            ),
          ],
        ),
      ),
    );
  }
}
