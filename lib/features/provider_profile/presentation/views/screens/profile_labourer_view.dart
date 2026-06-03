import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/container_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/custom_container.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/my_protifolio.dart';

class ProfileLabourerView extends StatelessWidget {
  const ProfileLabourerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 50.h),

        child: SingleChildScrollView(
          child: Column(
            children: [
              LangagueThemeWidget(),
              Gap(60.h),
              SingleChildScrollView(
                child: CustomContainer(
                  width: 360.w,
                  height: 320.h,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15).r,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: AssetImage(
                            "assets/images/avatar2.jpg",
                          ),
                        ),
                        Gap(10),
                        Text(
                          "John Doe",
                          style: TextStyles.onCard(
                            context,
                            TextStyles.font16PrimaryColorW600.copyWith(
                              fontSize: 18.sp,
                            ),
                          ),
                        ),
                        Gap(5),
                        Text(
                          "Cleaning | clean house",
                          style: TextStyles.onCard(
                            context,
                            TextStyles.font12PrimaryColorW600,
                          ),
                        ),
                        Gap(4),
                        Text(
                          "0988 888 888",
                          style: TextStyles.onCard(
                            context,
                            TextStyles.font12PrimaryColorW600,
                          ),
                        ),
                        Gap(4),
                        Text(
                          "homs | wadi al zahab ",
                          style: TextStyles.onCard(
                            context,
                            TextStyles.font12PrimaryColorW600.copyWith(
                              fontSize: 13.sp,
                            ),
                          ),
                        ),
                        Gap(24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ContainerWidget(
                                image: "assets/images/star_icon.png",
                                text: "avg rating",
                                number: 4.5,
                              ),
                              Gap(10),
                              Expanded(
                                child: ContainerWidget(
                                  image: "assets/images/pin.png",
                                  text: "Both(Fixed & Mobile)",
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(10),
                        Expanded(
                          child: ContainerWidget(
                            image: "assets/images/checked.png",
                            text: "available ",
                          ),
                        ),
                      ],
                    ),
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
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font12PrimaryColorW600,
                            ),
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
                          style: TextStyles.onCard(
                            context,
                            TextStyles.font12PrimaryColorW600,
                          ),
                        ),
                        Gap(12),
                        Row(
                          children: [
                            Icon(Icons.circle, size: 14.sp),
                            Gap(5),
                            Text(
                              "Saturday _ Thursday",
                              style: TextStyles.onCard(
                                context,
                                TextStyles.font12BlackW400,
                              ),
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
                              style: TextStyles.onCard(
                                context,
                                TextStyles.font12BlackW400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                            "Price",
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font12PrimaryColorW600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("2o000 - 30000 "),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(20),
              MyProtifolio(),
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
                              style: TextStyles.onCard(
                                context,
                                TextStyles.font12PrimaryColorW600,
                              ),
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
                                  style: TextStyles.onCard(
                                    context,
                                    TextStyles.font12BlackW400.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Gap(4),
                                Text(
                                  "Great service! Highly recommend.",
                                  style: TextStyles.onCard(
                                    context,
                                    TextStyles.font12BlackW400,
                                  ),
                                ),
                              ],
                            ),
                            Gap(20),
                            CustomButton(
                              width: 50.w,
                              height: 23.h,
                              title: "Report ",
                              textstyle: TextStyles.font11WhiteW500.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              onTap: () {},
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
