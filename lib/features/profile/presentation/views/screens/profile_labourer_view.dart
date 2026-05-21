import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/container_widget.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/custom_container.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/protfolio_widget.dart';

class ProfileLabourerView extends StatelessWidget {
  const ProfileLabourerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(left: 14.w, top: 50.h),

        child: SingleChildScrollView(
          child: Column(
            children: [
              LangagueThemeWidget(),
              Gap(60.h),
              CustomContainer(
                width: 360.w,
                height: 266.h,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15).r,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: AssetImage(
                          "assets/images/user_avatar.jpg",
                        ),
                      ),
                      Gap(10),
                      Text(
                        "John Doe",
                        style: TextStyles.font16PrimaryColorW600.copyWith(
                          fontSize: 18.sp,
                        ),
                      ),
                      Gap(5),
                      Text(
                        "Professional | electrical",
                        style: TextStyles.font12PrimaryColorW600,
                      ),
                      Gap(4),
                      Text(
                        "0988 888 888",
                        style: TextStyles.font12PrimaryColorW600,
                      ),
                      Gap(4),
                      Text(
                        "Hama | Located in Masyaf",
                        style: TextStyles.font12PrimaryColorW600.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),
                      Gap(24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ContainerWidget(
                              image: "assets/images/star_icon.png",
                              text: "Reviews",
                              number: 4.5,
                            ),
                            Gap(10),
                            ContainerWidget(
                              image: "assets/images/visits_Icon.png",
                              text: "Visits",
                              number: 140,
                            ),
                            Gap(10),
                            Expanded(
                              child: ContainerWidget(
                                image: "assets/images/Experince_icon.png",
                                text: "Experiance",
                                number: 5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(20),
              CustomContainer(
                width: 353.w,
                height: 80.h,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset("assets/images/about_him_icon.png"),
                          Gap(5),
                          Text(
                            "About him",
                            style: TextStyles.font12PrimaryColorW600,
                          ),
                        ],
                      ),
                    ),
                    Gap(4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("nnnk kn kkkkkkk jn"),
                      ),
                    ),
                  ],
                ),
              ),
              Gap(20),
              CustomContainer(
                width: 353.w,
                height: 106.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Working Hours and Days",
                          style: TextStyles.font12PrimaryColorW600,
                        ),
                        Gap(12),
                        Row(
                          children: [
                            Icon(Icons.circle, size: 14.sp),
                            Gap(5),
                            Text(
                              "Saturday _ Thursday",
                              style: TextStyles.font12BlackW400,
                            ),
                          ],
                        ),
                        Gap(7),
                        Row(
                          children: [
                            Icon(Icons.circle, size: 14.sp),
                            Gap(5),
                            Text(
                              "9 AM - 6 PM",
                              style: TextStyles.font12BlackW400,
                            ),
                          ],
                        ),
                        Gap(7),
                        Row(
                          children: [
                            Icon(Icons.circle, size: 14.sp),
                            Gap(5),
                            Text(
                              "20,000 SYP - 30,000 SYP",
                              style: TextStyles.font12BlackW400,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
              ProtfolioWidget(),
              Gap(20),
              CustomContainer(
                width: 353.w,
                height: 134.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset("assets/images/reviews_icon.png"),
                            Text(
                              "Customer Reviews and Ratings",
                              style: TextStyles.font12PrimaryColorW600,
                            ),
                          ],
                        ),
                        Gap(8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15.r,
                              backgroundImage: AssetImage(
                                "assets/images/user_avatar.jpg",
                              ),
                            ),
                            Gap(8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Jane Smith",
                                  style: TextStyles.font12BlackW400.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(4),
                                Text(
                                  "Great service! Highly recommend.",
                                  style: TextStyles.font12BlackW400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
