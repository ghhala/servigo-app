import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/provider_rating_card.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/service_category_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      padding: EdgeInsets.only(left: 14.w, top: 50.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LangagueThemeWidget(),

            Gap(16),
            CircleAvatar(
              radius: 45.r,
              backgroundImage: AssetImage(Assets.userAvatar),
            ),
            Gap(16),
            Text("Welcome Ali Ali", style: TextStyles.font16PrimaryColorW600),
            Text(
              "How Can We Help You Today ?",
              style: TextStyles.font16PrimaryColorW600.copyWith(
                fontSize: 14.sp,
              ),
            ),
            Gap(40),
            Container(
              width: 353.w,
              height: 110.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Image.asset(Assets.onBoardingView2),
                  Gap(20),
                  Text(
                    "High Quality and Competitive\n Prices For Your Home Services \nHigh Quality and Competitive\n Prices For Your Home Services ",
                    style: TextStyles.font12PrimaryColorW600,
                  ),
                ],
              ),
            ),
            Gap(20),
            Text(
              "Choose the service type to begin \n your search :",
              style: TextStyles.font16PrimaryColorW600,
            ),
            Gap(12),
            Container(
              width: 353.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ServiceCategoryCard(
                    name: 'Plumbing',
                    image: "assets/images/test.png",
                  );
                },
              ),
            ),
            Gap(20),
            Text(
              "Top five rated people",
              style: TextStyles.font16PrimaryColorW600,
            ),
            Gap(20),

            Wrap(
              spacing: 2.w,
              runSpacing: 6.h,

              children: List.generate(5, (index) {
                return SizedBox(
                  width: 120.w,
                  child: const ProviderRatingCard(
                    providerName: 'Ali Ali',
                    imageUrl: 'assets/images/test.png',
                    serviceType: 'Plumbing',
                    rating: 3,
                  ),
                );
              }),
            ),
            Gap(20),
            Container(
              width: 353.w,
              height: 180.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(13.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.w,
                      vertical: 20.h,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Painting Advertisement",
                          style: TextStyles.font25Blackw700.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        Gap(14),
                        Text(
                          "House Painting with High \n Professionalism  \nAffordable prices – guaranteed\nquality – fast execution",
                          style: TextStyles.font12PrimaryColorW600,
                        ),
                        Gap(18),
                        CustomButton(
                          height: 23.h,
                          width: 92.w,
                          title: "Go To Profile  ",
                          textstyle: TextStyles.font11WhiteW500,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/test2.png"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
