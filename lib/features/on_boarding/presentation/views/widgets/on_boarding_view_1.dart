import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
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
                    child: Image.asset(
                      'assets/images/on_boarding_view_image_1.png',
                    ),
                  ),
                  Gap(46.h),
                  Text(
                    "Your needs, one platform",
                    style: TextStyles.font25Blackw700,
                  ),
                  Gap(16),
                  Text(
                    "Find trusted professionals \n near you compare ratings\n and choose with confidence",
                    textAlign: TextAlign.center,
                    style: TextStyles.font25Blackw700.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Gap(70),
                  CustomButton(
                    title: "Next",
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
