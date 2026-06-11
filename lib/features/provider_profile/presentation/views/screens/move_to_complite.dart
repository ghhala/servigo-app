import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';

class MoveToComplite extends StatelessWidget {
  final String userType;
  final Map<String, dynamic>? userData;
  const MoveToComplite({super.key, this.userData, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 100.h),
          child: Container(
            width: 353.w,
            height: 239.h,

            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF2C9FEC), Color(0xFF7C3AED)],
              ),

              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),

              child: Column(
                children: [
                  Text(
                    "Complete your profile details to \n be able to post about your\n service , it is complete :",
                    style: TextStyles.font20White800,
                  ),
                  Gap(21.h),
                  LinearPercentIndicator(
                    lineHeight: 17.0,
                    percent: 0.75,
                    backgroundColor: Colors.white,
                    linearGradient: LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                    ),
                    barRadius: Radius.circular(10),
                    trailing: Text(
                      "75%",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Gap(30.h),
                  CustomButton(
                    title: 'Complete Your Profile',
                    textstyle: TextStyles.font26WhiteW600.copyWith(
                      fontSize: 20.sp,
                    ),
                    width: 280.w,
                    height: 40.h,
                    onTap: () {
                      GoRouter.of(
                        context,
                      ).push(AppRouter.kCompliteProfileProviderView,
                      extra: {
                        'userType': userType,
                        'userData': userData,
                      },
                       );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
