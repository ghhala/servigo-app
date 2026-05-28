import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/Profile_photo_widget.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.34,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: 435.w,
                height: 250.h,
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 50.r, backgroundImage: AssetImage("")),
                    SizedBox(height: 10.h),
                    Text("Ahmed Khaled"),
                    Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.phone, size: 17.sp),
                        Text("0988 888 888"),
                      ],
                    ),
                    Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.email, size: 17.sp),
                        Text("hghj@gmail.com"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Gap(50),
            CustomButton(
              width: 140.w,
              height: 30.h,
              textstyle: TextStyles.font11WhiteW500.copyWith(fontSize: 15.sp),
              title: "edit profile",
              onTap: () {
                GoRouter.of(context).push(AppRouter.kEditeProfile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
