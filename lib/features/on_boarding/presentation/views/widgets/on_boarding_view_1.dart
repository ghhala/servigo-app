import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';

class OnBoardingView1 extends StatelessWidget {
  const OnBoardingView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 36),
              child: Image.asset('assets/images/on_boarding_view_image_1.png'),
            ),
            Gap(46.h),
            Text(
              AppLocalizations.of(context)!.onBoardingTitle1,
              style: TextStyles.font25Blackw700.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            Gap(16),
            Text(
              AppLocalizations.of(context)!.onBoardingDescription1,
              textAlign: TextAlign.center,
              style: TextStyles.font25Blackw700.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            Gap(70),
            CustomButton(
              title: AppLocalizations.of(context)!.next,
              icon: Icons.arrow_forward,
              onTap: () {
                GoRouter.of(context).push(AppRouter.kOnboarding2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
