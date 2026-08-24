import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/localization/app_localizations.dart';
import 'package:servi_go_app/core/utils/api_constants.dart';
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

  const HomeBody({
    super.key,
    required this.userType,
    this.userData,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHomeData();
  }

  String _getFullImageUrl(String? path) {
    if (path == null || path.trim().isEmpty) return '';
    final cleanPath = path.trim();

    if (cleanPath.startsWith('http://') || cleanPath.startsWith('https://')) {
      if (cleanPath.contains('/storage/')) {
        final relativePath = cleanPath.split('/storage/').last;
        return '${ApiConstants.storageBaseUrl}$relativePath';
      }
      return cleanPath;
    }
    return '${ApiConstants.storageBaseUrl}$cleanPath';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
                    l10n.errorMessage(state.errorMessage),
                    style: const TextStyle(color: Colors.red),
                  ),
                  const Gap(10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomeCubit>().fetchHomeData();
                    },
                    child: Text(l10n.retry),
                  ),
                ],
              ),
            );
          }

          if (state is HomeSuccess) {
            final mainServices = state.homeData.data?.mainServices ?? [];
            final favorites = state.homeData.data?.favorites ?? [];
            final ads = state.homeData.data?.ads ?? [];

            final String userName = PrefHelper.getString('user_name') ?? l10n.user;

            String? finalPhotoPath;
            final String localCachedImage = PrefHelper.getUserImage();

            if (localCachedImage.isNotEmpty) {
              finalPhotoPath = localCachedImage;
            }

            String? fullUserImageUrl;
            if (finalPhotoPath != null && finalPhotoPath.isNotEmpty) {
              fullUserImageUrl = finalPhotoPath;
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
                    borderRadius: BorderRadius.circular(
                      widget.userType == 'labourer' ? 45.r : 35.r,
                    ),
                    child: Container(
                      width: widget.userType == 'labourer' ? 90.w : 70.w,
                      height: widget.userType == 'labourer' ? 90.h : 70.h,
                      color: fullUserImageUrl == null
                          ? Colors.deepPurpleAccent
                          : const Color(0xFFF3F2F2),
                      child: fullUserImageUrl != null
                          ? (fullUserImageUrl.startsWith('http')
                              ? Image.network(
                                  fullUserImageUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text(
                                        firstLetter,
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Image.file(
                                  File(fullUserImageUrl),
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Text(
                                        firstLetter,
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
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
                    l10n.welcomeUser(userName),
                    style: TextStyles.font16PrimaryColorW600,
                  ),
                  Text(
                    l10n.homeHelpPrompt,
                    style: TextStyles.font16PrimaryColorW600.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  const Gap(40),

                  // ---------------- STATIC BANNER ----------------
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
                        Expanded(
                          child: Text(
                            l10n.homeBannerText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font12PrimaryColorW600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(20),
                  Text(
                    l10n.chooseServiceTypePrompt,
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
                        ? Center(child: Text(l10n.noServicesAvailable))
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: mainServices.length,
                            itemBuilder: (context, index) {
                              final service = mainServices[index];
                              final serviceImage = _getFullImageUrl(service.photo);

                              final serviceName = Localizations.localeOf(context).languageCode == 'ar'
                                  ? (service.nameAr ?? service.nameEn ?? l10n.service)
                                  : (service.nameEn ?? service.nameAr ?? l10n.service);

                              return GestureDetector(
                                onTap: () {
                                  context.push(
                                    AppRouter.kFilterView,
                                    extra: {
                                      'mainServiceId': service.id ?? 0,
                                      'mainServiceName': serviceName,
                                    },
                                  );
                                },
                                child: ServiceCategoryCard(
                                  name: service.nameEn ?? service.nameAr ?? l10n.service,
                                  nameAr: service.nameAr,
                                  nameEn: service.nameEn,
                                  image: serviceImage,
                                ),
                              );
                            },
                          ),
                  ),

                  const Gap(20),
                  Text(
                    l10n.favoriteProviders,
                    style: TextStyles.font16PrimaryColorW600,
                  ),
                  const Gap(20),

                  // ---------------- FAVORITES ----------------
                  favorites.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(l10n.noFavoriteProviders),
                        )
                      : Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: List.generate(favorites.length, (index) {
                            final provider = favorites[index];
                            final providerImage = _getFullImageUrl(provider.photo);

                            return SizedBox(
                              width: 150.w,
                              child: GestureDetector(
                                onTap: () async {
                                  if (provider.providerUserId != null) {
                                    await context.push(
                                      AppRouter.kProfileLabourer,
                                      extra: provider.providerUserId,
                                    );
                                    if (context.mounted) {
                                      context.read<HomeCubit>().fetchHomeData();
                                    }
                                  }
                                },
                                child: FavoriteProviderCard(
                                  providerName: provider.name ?? l10n.unknownProvider,
                                  imageUrl: providerImage,
                                  mainService:
                                      provider.mainService?.nameEn ?? l10n.service,
                                  subService:
                                      provider.subService?.nameEn ?? l10n.service,
                                ),
                              ),
                            );
                          }),
                        ),

                  const Gap(20),

                
              
                  // ---------------- ADS ----------------
ads.isEmpty
    ? const SizedBox.shrink()
    : Builder(
        builder: (context) {
          final displayAds = ads.reversed.toList(); 

          return Column(
            children: List.generate(displayAds.length, (index) {
              final ad = displayAds[index];
              final adImage = _getFullImageUrl(ad.adImage);

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
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 15.w,
                          vertical: 20.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ad.providerName ?? "Advertisement",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyles.onCard(
                                context,
                                TextStyles.font25Blackw700.copyWith(fontSize: 14.sp),
                              ),
                            ),
                            const Gap(14),
                            Expanded(
                              child: Text(
                                ad.description ?? "Description here...",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font12PrimaryColorW600,
                                ),
                              ),
                            ),
                            const Gap(10),
                            CustomButton(
                              height: 30.h,
                              width: 110.w,
                              title: "Go To Profile",
                              textstyle: TextStyles.font11WhiteW500,
                              onTap: () async {
                                if (ad.providerUserId != null) {
                                  await context.push(
                                    AppRouter.kProfileLabourer,
                                    extra: ad.providerUserId,
                                  );
                                  if (context.mounted) {
                                    context.read<HomeCubit>().fetchHomeData();
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: adImage.isNotEmpty
                            ? Image.network(
                                adImage,
                                width: 120.w,
                                height: 140.h,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    "assets/images/test2.png",
                                    width: 120.w,
                                    height: 140.h,
                                    fit: BoxFit.cover,
                                  );
                                },
                              )
                            : Image.asset(
                                "assets/images/test2.png",
                                width: 120.w,
                                height: 140.h,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        },
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