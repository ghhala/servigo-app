import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';

class AuthLandingView extends StatelessWidget {
  final String userType;
  const AuthLandingView({super.key, required this.userType});

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
              left: 16.w,
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
              right: 0,
              top: 160.h,
              left: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 42),
                    child: SvgPicture.asset(Assets.logo),
                  ),
                  Gap(108.h),
                  Text(
                    "create account",
                    style: TextStyles.font22BlackW600.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Gap(16.h),
                  CustomButton(
                    title: "Sign Up",
                    width: 250.w,
                    onTap: () {
                      userType == 'user'
                          ? GoRouter.of(context).pushReplacement(
                              AppRouter.ksignupuser,
                              extra: 'user',
                            )
                          : GoRouter.of(context).pushReplacement(
                              AppRouter.kuserlabourer,
                              extra: 'labourer',
                            );
                    },
                  ),
                  Gap(96.h),
                  Text(
                    "you already have account ?",
                    style: TextStyles.font22BlackW600.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                  Gap(16.h),
                  CustomButton(
                    title: "Log In",
                    width: 250.w,
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).pushReplacement(AppRouter.klogIn, extra: userType);
                    },
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
