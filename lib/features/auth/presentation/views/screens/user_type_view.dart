import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';

class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset('assets/images/Vector1.png'),
            ),

            Positioned(
              top: 0,
              left: 10.w,
              child: Image.asset('assets/images/Vector(2).png'),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset('assets/images/Vector(4).png'),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset('assets/images/Vector(3).png'),
            ),
            Positioned(
              top: 50.h,
              child: Row(children: [LangagueThemeWidget()]),
            ),
            Positioned(
              right: 0,
              top: 160.h,
              left: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42),
                    child: SvgPicture.asset(Assets.logo),
                  ),
                  Gap(67.h),
                  Text(
                    "Select account type",
                    style: TextStyles.font16BlackW700.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Gap(48.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushReplacement(
                              AppRouter.kauthlandingview,
                              extra: 'user',
                            );
                          },
                          child: SvgPicture.asset("assets/images/user.svg"),
                        ),
                        Gap(34.w),
                        GestureDetector(
                          onTap: () {
                            GoRouter.of(context).pushReplacement(
                              AppRouter.kauthlandingview,
                              extra: 'labourer',
                            );
                          },
                          child: SvgPicture.asset("assets/images/labourer.svg"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
