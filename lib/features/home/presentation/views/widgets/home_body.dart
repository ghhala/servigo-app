import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/assets.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';
import 'package:servi_go_app/features/home/presentation/view_models/home/cubit/home_cubit.dart';
import 'package:servi_go_app/features/home/presentation/view_models/home/cubit/home_state.dart';

import 'package:servi_go_app/features/home/presentation/views/widgets/favorite_provider_card.dart';
import 'package:servi_go_app/features/home/presentation/views/widgets/service_category_card.dart';

class HomeBody extends StatefulWidget {
  final String userType;
  final dynamic userData; 

  const HomeBody({super.key, required this.userType, this.userData});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).fetchHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      withScaffold: false,
      padding: EdgeInsets.only(left: 9.w, top: 50.h),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              ),
            );
          }

          if (state is HomeFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Error: ${state.errorMessage}",
                    style: const TextStyle(color: Colors.red),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().fetchHomeData();
                    },
                    child: const Text("Retry"),
                  ),
                ],
              ),
            );
          }

          if (state is HomeSuccess) {
            final mainServices = state.homeData.data?.mainServices ?? [];
            final favorites = state.homeData.data?.favorites ?? [];
            final ads = state.homeData.data?.ads ?? [];

            final String userName = PrefHelper.getString('user_name') ?? 'User';

           
            String? finalPhotoPath;
            final String localCachedImage = PrefHelper.getUserImage();
            
            if (localCachedImage.isNotEmpty) {
              finalPhotoPath = localCachedImage;
            }

           
            String? fullUserImageUrl;
            if (finalPhotoPath != null) {
              fullUserImageUrl = finalPhotoPath.startsWith('http') || finalPhotoPath.startsWith('/') && !finalPhotoPath.contains('data/')
                  ? (finalPhotoPath.startsWith('http') ? finalPhotoPath : 'http://10.0.2.2:8000$finalPhotoPath')
                  : finalPhotoPath; 
            }

            final String firstLetter = userName.trim().isNotEmpty
                ? userName.trim()[0].toUpperCase()
                : 'U';

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LangagueThemeWidget(),
                  const Gap(16),
                  
             
                  ClipRRect(
                    borderRadius: BorderRadius.circular(widget.userType == 'labourer' ? 45.r : 35.r),
                    child: Container(
                      width: widget.userType == 'labourer' ? 90.w : 70.w,
                      height: widget.userType == 'labourer' ? 90.h : 70.h,
                      color: fullUserImageUrl == null ? Colors.deepPurpleAccent : const Color(0xFFF3F2F2),
                      child: fullUserImageUrl != null
                          ? (fullUserImageUrl.startsWith('http')
                              ? Image.network(
                                  fullUserImageUrl,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                                      ),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) => Center(
                                    child: Text(
                                      firstLetter,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Image.file(
                                  File(fullUserImageUrl), 
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Center(
                                    child: Text(
                                      firstLetter,
                                      style: TextStyle(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ))
                          : Center(
                              child: Text(
                                firstLetter,
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                  
                  const Gap(16),
                  Text(
                    "Welcome $userName",
                    style: TextStyles.font16PrimaryColorW600,
                  ),
                  Text(
                    "How Can We Help You Today ?",
                    style: TextStyles.font16PrimaryColorW600.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  const Gap(40),
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
                        const Gap(5),
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
                  const Gap(20),
                  Text(
                    "Choose the service type to begin \n your search :",
                    style: TextStyles.font16PrimaryColorW600,
                  ),
                  const Gap(12),
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
                    child: mainServices.isEmpty
                        ? const Center(child: Text("No services available"))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: mainServices.length,
                          itemBuilder: (context, index) {
  final service = mainServices[index];
  
 return GestureDetector(
  onTap: () {

    context.push(
     AppRouter.kFilterView, 
      extra: {
        'mainServiceId': service.id ?? 0,
        'mainServiceName': service.nameEn ?? 'Service',
      },
    );
  },
  child: ServiceCategoryCard(
    name: service.nameEn ?? 'Service',
    image: service.photo ?? "assets/images/test.png",
  ),
);
},
                          ),
                  ),
                  const Gap(20),
                  Text(
                    "Favorite Providers :",
                    style: TextStyles.font16PrimaryColorW600,
                  ),
                  const Gap(20),
                  favorites.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text("No favorite providers yet"),
                        )
                      : Wrap(
                          spacing: 2.w,
                          runSpacing: 6.h,
                          children: List.generate(favorites.length, (index) {
                            final provider = favorites[index];
                            return SizedBox(
                              width: 120.w,
                              child: FavoriteProviderCard(
                                providerName: provider.name ?? "Sara Ali",
                                imageUrl: provider.photo ?? "assets/images/test.png",
                                mainService: provider.mainService?.nameEn ?? "Cleaning",
                                subService: provider.subService?.nameEn ?? "House Cleaning",
                              ),
                            );
                          }),
                        ),
                  const Gap(20),
                  ads.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          children: List.generate(ads.length, (index) {
                            final ad = ads[index];
                            return Container(
                              width: 353.w,
                              height: 200.h,
                              margin: EdgeInsets.only(bottom: 15.h),
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            ad.titleEn ?? "Advertisement",
                                            style: TextStyles.onCard(
                                              context,
                                              TextStyles.font25Blackw700.copyWith(
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                          const Gap(14),
                                          Text(
                                            ad.contentEn ?? "Description here...",
                                            style: TextStyles.onCard(
                                              context,
                                              TextStyles.font12PrimaryColorW600,
                                            ),
                                          ),
                                          const Gap(20),
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
                                    ad.photo != null
                                        ? Image.network(
                                            ad.photo!,
                                            width: 120.w,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) =>
                                                Image.asset("assets/images/test2.png"),
                                          )
                                        : Image.asset("assets/images/test2.png"),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}