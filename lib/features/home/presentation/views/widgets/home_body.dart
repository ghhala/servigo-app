import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/favorite_provider_card.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/service_category_card.dart';

class HomeBody extends StatelessWidget {
  final String userType;

  const HomeBody({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      withScaffold: false,
      padding: EdgeInsets.only(left: 9.w, top: 50.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LangagueThemeWidget(),

            Gap(16),
            (userType == 'labourer')
                ? CircleAvatar(
                    radius: 45.r,
                    backgroundImage: AssetImage("assets/images/avatar2.jpg"),
                  )
                : CircleAvatar(
                    radius: 45.r,
                    backgroundImage: AssetImage("assetsimages/avatar2.jpg"),
                  ),

            Gap(16),
            Text(
              "Welcome Hala Ghassa",
              style: TextStyles.font16PrimaryColorW600,
            ),
            Text(
              "How Can We Help You Today ?",
              style: TextStyles.font16PrimaryColorW600.copyWith(
                fontSize: 14.sp,
              ),
            ),
            Gap(40),
            Container(
              width: 390.w,
              height: 115.h,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
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
                  Gap(5),
                  Text(
                    overflow: TextOverflow.ellipsis,
                    "High Quality and Competitive\n Prices For Your Home Services \nHigh Quality and Competitive\n Prices For Your Home Services ",
                    style: TextStyles.onCard(
                      context,
                      TextStyles.font12PrimaryColorW600,
                    ),
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
                color: Theme.of(context).cardColor,
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
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ServiceCategoryCard(
                    name: 'Cleaning',
                    image: "assets/images/test.png",
                  );
                },
              ),
            ),
            Gap(20),
            Text(
              "Favorite Providers :",
              style: TextStyles.font16PrimaryColorW600,
            ),
            Gap(20),

            Wrap(
              spacing: 2.w,
              runSpacing: 6.h,

              children: List.generate(7, (index) {
                return SizedBox(
                  width: 120.w,
                  child: FavoriteProviderCard(
                    providerName: "sara ali",
                    imageUrl: "assets/images/test.png",
                    mainService: "Cleaning",
                    subService: "House Cleaning",
                  ),
                );
              }),
            ),
            Gap(20),
            Container(
              width: 353.w,
              height: 200.h,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(13.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font25Blackw700.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Gap(14),
                          Text(
                            "House Painting with High \n Professionalism  \nAffordable prices – guaranteed\nquality – fast execution",
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font12PrimaryColorW600,
                            ),
                          ),
                          Gap(20),
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
            ),
          ],
        ),
      ),
    );
  }
}
