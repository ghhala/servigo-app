import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';
import 'package:servi_go_app/features/home/presentation/view_models/home/cubit/home_cubit.dart';
import 'package:servi_go_app/features/home/presentation/view_models/home/cubit/home_state.dart';
import 'package:servi_go_app/features/messaging/data/data_sources/chat_remote_data_source.dart';
import 'package:servi_go_app/features/messaging/data/repositories/chat_repository.dart';
import 'package:servi_go_app/features/messaging/presentation/view_models/chat/chat_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_state.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/sub_services/sub_services_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/sub_services/sub_services_state.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/sub_services_repository.dart';
import 'package:servi_go_app/features/provider_profile/data/data_sources/sub_services_remote_data_source.dart';
import 'package:servi_go_app/features/home/data/repositories/home_repository.dart';
import 'package:servi_go_app/features/home/data/data_sources/home_remote_data_source.dart';
import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/core/network/dio_client.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/container_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/custom_container.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/my_protifolio.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/my_certificates.dart';

class ProfileLabourerView extends StatefulWidget {
  final int? providerId;
  const ProfileLabourerView({super.key, this.providerId});

  @override
  State<ProfileLabourerView> createState() => _ProfileLabourerViewState();
}

class _ProfileLabourerViewState extends State<ProfileLabourerView> {
  int? _lastFetchedMainServiceId;

  bool get isOwner => widget.providerId == null;

  @override
  void initState() {
    super.initState();

    context.read<ProviderProfileCubit>().fetchProviderProfile(
      providerId: widget.providerId,
    );
  }

  String getCorrectImageUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.contains('localhost')) {
      return path.replaceAll('localhost', '10.0.2.2');
    }
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return path;
    }
    return "http://10.0.2.2/servigo/public/$path";
  }

 
  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return "";
    try {
      final date = DateTime.parse(rawDate);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return rawDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SubServicesCubit>(
          create: (_) => SubServicesCubit(
            SubServicesRepository(
              SubServicesRemoteDataSource(ApiService(DioClient())),
            ),
          ),
        ),
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(
            HomeRepository(HomeRemoteDataSource(ApiService(DioClient()))),
          )..fetchHomeData(),
        ),
      ],
      child: Scaffold(
        body: AppBackground(
          withScaffold: false,
          padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 50.h),
          child: BlocConsumer<ProviderProfileCubit, ProviderProfileState>(
            listener: (context, state) {},
            builder: (context, state) {
              // ── Loading ──
              if (state is ProviderProfileLoading) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              // ── Failure ──
              if (state is ProviderProfileFailure) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.lock_person_outlined,
                            color: Colors.redAccent,
                            size: 50,
                          ),
                          const Gap(16),
                          Text(
                            state.errorMessage.contains("unauthorized")
                                ? "Session expired. Please log in again."
                                : state.errorMessage,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Gap(20),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                            ),
                            onPressed: () {
                              context
                                  .read<ProviderProfileCubit>()
                                  .fetchProviderProfile();
                            },
                            child: const Text(
                              "Retry",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }

              // ── Success ──
              if (state is ProviderProfileSuccess) {
                final profileData = state.profileModel.data;
                final user = profileData?.user;
                final provider = profileData?.provider;

                final mainServiceId = provider?.mainServiceId;
                if (mainServiceId != null &&
                    mainServiceId != _lastFetchedMainServiceId) {
                  _lastFetchedMainServiceId = mainServiceId;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      context.read<SubServicesCubit>().fetchSubServices(
                        mainServiceId,
                      );
                    }
                  });
                }

                final String languageCode = Localizations.localeOf(
                  context,
                ).languageCode;
                final bool isArabic = languageCode == 'ar';

                Widget buildServiceLine() {
                  return BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, homeState) {
                      String mainServiceText = provider?.mainServiceName ?? '';

                      if (homeState is HomeSuccess) {
                        final mainServicesList =
                            homeState.homeData.data?.mainServices ?? [];
                        final mainMatch = mainServicesList.where(
                          (s) => s.id == provider?.mainServiceId,
                        );
                        if (mainMatch.isNotEmpty) {
                          final service = mainMatch.first;
                          mainServiceText =
                              (isArabic ? service.nameAr : service.nameEn) ??
                              mainServiceText;
                        }
                      }

                      return BlocBuilder<SubServicesCubit, SubServicesState>(
                        builder: (context, subState) {
                          String subServiceText =
                              provider?.subServiceName ?? '';

                          if (subState is SubServicesSuccess) {
                            final match = subState.subServices.where(
                              (s) => s.id == provider?.subServiceId,
                            );
                            if (match.isNotEmpty) {
                              final service = match.first;
                              subServiceText =
                                  (isArabic
                                      ? service.nameAr
                                      : service.nameEn) ??
                                  '';
                            }
                          }

                          return Text(
                            "$mainServiceText | $subServiceText",
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font12PrimaryColorW600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          );
                        },
                      );
                    },
                  );
                }

                const allDays = [
                  'sunday',
                  'monday',
                  'tuesday',
                  'wednesday',
                  'thursday',
                  'friday',
                  'saturday',
                ];
                final offDays = provider?.offDays ?? [];
                final workingDays = allDays
                    .where((d) => !offDays.contains(d))
                    .map((d) => d[0].toUpperCase() + d.substring(1))
                    .join(', ');

                final avatarUrl = getCorrectImageUrl(user?.photo);

                final finalRating =
                    double.tryParse(
                      profileData?.avgRating?.toString() ?? '0',
                    ) ??
                    0.0;

                final portfolioItems = (profileData?.portfolio ?? [])
                    .where((e) => e.filePath != null)
                    .map(
                      (e) => {
                        'file_path': getCorrectImageUrl(e.filePath),
                        'file_type': e.fileType ?? 'image',
                        'description': e.description ?? '',
                      },
                    )
                    .toList();

                final certificateItems = (profileData?.certificates ?? [])
                    .where((e) => e.filePath != null)
                    .map((e) => {'file_path': getCorrectImageUrl(e.filePath)})
                    .toList();

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const LangagueThemeWidget(),
                      Gap(20.h),

                      CustomContainer(
                        width: 360.w,
                        height: isOwner ? 350.h : 420.h,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15).r,
                          child: Column(
                            children: [
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleAvatar(
                                    radius: 30.r,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: avatarUrl.isNotEmpty
                                        ? NetworkImage(avatarUrl)
                                        : const AssetImage(
                                                "assets/images/avatar2.jpg",
                                              )
                                              as ImageProvider,
                                  ),
                                  // ✅ نقطة حالة التوفر — إشارة سريعة بالإضافة للنص أسفل (Available/Unavailable)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 14.r,
                                      height: 14.r,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: provider?.isAvailable == 1
                                            ? Colors.green
                                            : Colors.grey,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (!isOwner)
                                    Positioned(
                                      top: -6,
                                      right: -6,
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            await context
                                                .read<ProviderProfileCubit>()
                                                .toggleFavourite(
                                                  providerId:
                                                      widget.providerId!,
                                                );
                                          } catch (e) {
                                            if (!context.mounted) return;
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "فشل تحديث المفضلة",
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(4.r),
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black12,
                                                blurRadius: 4,
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            (profileData?.isFavourite ?? false)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 16.sp,
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              Gap(10.h),
                              Text(
                                user?.name ?? "No Name",
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font16PrimaryColorW600.copyWith(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(5.h),

                              buildServiceLine(),
                              Gap(4.h),
                              Text(
                                user?.phone ?? "No Phone",
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font12PrimaryColorW600,
                                ),
                              ),
                              Gap(4.h),
                              Text(
                                "${provider?.locationName ?? ''} | ${provider?.locationDescription ?? ''}",
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font12PrimaryColorW600.copyWith(
                                    fontSize: 13.sp,
                                  ),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(20.h),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ).r,
                                child: Row(
                                  children: [
                                    ContainerWidget(
                                      image: "assets/images/star_icon.png",
                                      text: "avg rating",
                                      number: finalRating,
                                    ),
                                    Gap(10.w),
                                    Expanded(
                                      child: ContainerWidget(
                                        image: "assets/images/pin.png",
                                        text:
                                            provider?.workType ??
                                            "Both(Fixed & Mobile)",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(10.h),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ).r,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ContainerWidget(
                                        image:
                                            "assets/images/convenience (1).png",
                                        text: provider?.isAvailable == 1
                                            ? "Available"
                                            : "Unavailable",
                                      ),
                                    ),
                                    Gap(10.w),
                                    Expanded(
                                      child: ContainerWidget(
                                        image: "assets/images/moon.png",
                                        text:
                                            "Overnight: ${provider?.overnight == true ? 'Yes' : 'No'}",
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              if (!isOwner) ...[
                                Gap(14.h),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ).r,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: CustomButton(
                                          height: 40.h,
                                          title: "Contact",
                                          textstyle: TextStyles.font11WhiteW500,
                                         onTap: () async {
 
  final providerId = widget.providerId;
  if (providerId == null) return;

 
  final chatCubit = ChatCubit(
    ChatRepository(
      ChatRemoteDataSource(ApiService(DioClient())),
    ),
  );

  final chatId = await chatCubit.startChat(providerId);

  if (chatId != null && context.mounted) {
    GoRouter.of(context).push(
      AppRouter.kChatRoom,
      extra: {
        'chatId': chatId,
        'otherPartyName': user?.name ?? 'Provider',
        'otherPartyPhoto': user?.photo,
      },
    );
  }
},
                                        ),
                                      ),
                                      Gap(10.w),
                                      GestureDetector(
                                        onTap: () =>
                                            _showComplaintDialog(context),
                                        child: Container(
                                          width: 40.h,
                                          height: 40.h,
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              8.r,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.flag_outlined,
                                            color: Colors.redAccent,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      Gap(20.h),

                      // ── About Him / About Me ──
                      CustomContainer(
                        width: 353.w,
                        height: 90.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/about_him_icon.png",
                                  ),
                                  Gap(5.w),
                                  Text(
                                    isOwner ? "About me" : "About him",
                                    style: TextStyles.onCard(
                                      context,
                                      TextStyles.font12PrimaryColorW600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(2.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                provider?.aboutMe ??
                                    (isOwner
                                        ? "You haven't written a bio yet."
                                        : "No info written by provider."),
                                style: TextStyle(fontSize: 12.sp),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20.h),

                      // ── Working Hours and Days ──
                      CustomContainer(
                        width: 353.w,
                        height: 106.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 8.h,
                          ),
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
                              Gap(12.h),
                              Row(
                                children: [
                                  Icon(Icons.circle, size: 14.sp),
                                  Gap(5.w),
                                  Expanded(
                                    child: Text(
                                      workingDays.isEmpty
                                          ? "All Days"
                                          : workingDays,
                                      style: TextStyles.onCard(
                                        context,
                                        TextStyles.font12BlackW400,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(7.h),
                              Row(
                                children: [
                                  Icon(Icons.circle, size: 14.sp),
                                  Gap(5.w),
                                  Text(
                                    "${provider?.workStartTime ?? '09:00'} - ${provider?.workEndTime ?? '18:00'}",
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
                      Gap(20.h),

                      // ── Price ──
                      CustomContainer(
                        width: 353.w,
                        height: 80.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/about_him_icon.png",
                                  ),
                                  Gap(5.w),
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
                            Gap(4.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Builder(
                                builder: (context) {
                                  String minStr =
                                      provider?.minPrice?.toString().trim() ??
                                      '0';
                                  String maxStr =
                                      provider?.maxPrice?.toString().trim() ??
                                      '0';

                                  if (minStr.contains('.')) {
                                    minStr = minStr.split('.').first;
                                  }
                                  if (maxStr.contains('.')) {
                                    maxStr = maxStr.split('.').first;
                                  }

                                  final int minPrice =
                                      int.tryParse(minStr) ?? 0;
                                  final int maxPrice =
                                      int.tryParse(maxStr) ?? 0;

                                  return Text(
                                    "$minPrice - $maxPrice ${provider?.currency ?? 'SYP'}",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20.h),

                      if (portfolioItems.isNotEmpty) ...[
                        MyPortfolio(portfolioList: portfolioItems),
                        Gap(20.h),
                      ],

                      if (certificateItems.isNotEmpty) ...[
                        MyCertificates(certificatesList: certificateItems),
                        Gap(20.h),
                      ],

                      // ── Customer Reviews and Ratings ──
                      // ✅ ما عاد في height مقفول محسوب يدويًا — الكارد هلق ياخد
                      // ارتفاعه تلقائيًا من طول المحتوى الفعلي (بغض النظر عن عدد
                      // التقييمات أو طول كل نص مراجعة)، فمافي overflow ممكن يصير مستقبلاً
                      CustomContainer(
                        width: 353.w,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Image.asset("assets/images/reviews_icon.png"),
                                  Expanded(
                                    child: Text(
                                      " Customer Reviews and Ratings",
                                      style: TextStyles.onCard(
                                        context,
                                        TextStyles.font12PrimaryColorW600,
                                      ),
                                    ),
                                  ),
                                  if (!isOwner)
                                    CustomButton(
                                      width: 90.w,
                                      height: 28.h,
                                      title: "+ Add Review",
                                      textstyle: TextStyles.font11WhiteW500,
                                      onTap: () =>
                                          _showAddReviewDialog(context),
                                    ),
                                ],
                              ),
                              Gap(8.h),
                              profileData?.ratings == null ||
                                      profileData!.ratings!.isEmpty
                                  ? Padding(
                                      padding: EdgeInsets.only(top: 15.h),
                                      child: Text(
                                        "No reviews yet",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: profileData.ratings!.map((r) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 10.h,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: 15.r,
                                                backgroundImage:
                                                    (r.customerPhoto != null &&
                                                        r
                                                            .customerPhoto!
                                                            .isNotEmpty)
                                                    ? NetworkImage(
                                                        getCorrectImageUrl(
                                                          r.customerPhoto,
                                                        ),
                                                      )
                                                    : const AssetImage(
                                                            "assets/images/user_avatar.jpg",
                                                          )
                                                          as ImageProvider,
                                              ),
                                              Gap(8.w),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          r.customerName ??
                                                              "Unknown",
                                                          style: TextStyles.onCard(
                                                            context,
                                                            TextStyles
                                                                .font12BlackW400
                                                                .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                          ),
                                                        ),
                                                        Gap(6.w),
                                                        Row(
                                                          children: List.generate(5, (
                                                            i,
                                                          ) {
                                                            return Icon(
                                                              i < (r.rating ?? 0)
                                                                  ? Icons.star
                                                                  : Icons.star_border,
                                                              size: 12.sp,
                                                              color:
                                                                  Colors.amber,
                                                            );
                                                          }),
                                                        ),
                                                      ],
                                                    ),
                                                    Gap(4.h),
                                                    Text(
                                                      r.review ?? "",
                                                      style: TextStyles.onCard(
                                                        context,
                                                        TextStyles
                                                            .font12BlackW400,
                                                      ),
                                                    ),
                                                    Gap(2.h),
                                                    Text(
                                                      _formatDate(r.createdAt),
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // ✅ زر الإبلاغ يظهر فقط لصاحب البروفايل (المزود)
                                              if (isOwner)
                                                CustomButton(
                                                  width: 50.w,
                                                  height: 23.h,
                                                  title: "Report",
                                                  textstyle: TextStyles
                                                      .font11WhiteW500
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                  onTap: () {
                                                    if (r.id != null) {
                                                      _showReportReviewDialog(
                                                        context,
                                                        r.id!,
                                                      );
                                                    }
                                                  },
                                                ),
                                              // ✅ زر الحذف يظهر فقط لصاحب
                                              // المراجعة نفسه (الزبون)، بناءً
                                              // على myRatingIds
                                              if (!isOwner &&
                                                  r.id != null &&
                                                  state.myRatingIds.contains(
                                                    r.id,
                                                  ))
                                                CustomButton(
                                                  width: 50.w,
                                                  height: 23.h,
                                                  title: "Delete",
                                                  textstyle: TextStyles
                                                      .font11WhiteW500
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                  onTap: () {
                                                    _confirmDeleteReview(
                                                      context,
                                                      r.id!,
                                                    );
                                                  },
                                                ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      Gap(20.h),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void _showComplaintDialog(BuildContext context) {
    final providerProfileCubit = context.read<ProviderProfileCubit>();
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("send complaint"),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(hintText: "write the complaint..."),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final message = controller.text.trim();
              Navigator.pop(dialogContext);

              if (message.isEmpty) return;

              try {
                await providerProfileCubit.sendComplaint(
                  providerId: widget.providerId!,
                  message: message,
                );
                if (!mounted) return;
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text("send complaint successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text("Failed to send complaint"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text("Send"),
          ),
        ],
      ),
    );
  }

  // ✅ dialog سبب البلاغ عن مراجعة، يستدعي reportRating بالكيوبت
  void _showReportReviewDialog(BuildContext context, int ratingId) {
    final providerProfileCubit = context.read<ProviderProfileCubit>();
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Report review"),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Why are you reporting this review?",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final reason = controller.text.trim();
              Navigator.pop(dialogContext);

              if (reason.isEmpty) return;

              try {
                await providerProfileCubit.reportRating(
                  ratingId: ratingId,
                  reason: reason,
                );
                if (!mounted) return;
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text("Review reported successfully"),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text("Failed to report review"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text("Report", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // ✅ تأكيد قبل حذف مراجعة، بيستدعي deleteRating بالكيوبت
  void _confirmDeleteReview(BuildContext context, int ratingId) {
    final providerProfileCubit = context.read<ProviderProfileCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete review"),
        content: const Text(
          "Are you sure you want to delete your review? This action cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              try {
                await providerProfileCubit.deleteRating(ratingId);
              } catch (e) {
                if (!mounted) return;
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(
                    content: Text("Failed to delete review"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddReviewDialog(BuildContext context) {
    final providerProfileCubit = context.read<ProviderProfileCubit>();

    int selectedRating = 5;
    final reviewController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: const Text("Add Review"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return GestureDetector(
                      onTap: () {
                        setStateDialog(() => selectedRating = starIndex);
                      },
                      child: Icon(
                        starIndex <= selectedRating
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                        size: 28,
                      ),
                    );
                  }),
                ),
                const Gap(12),
                TextField(
                  controller: reviewController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Write your review...",
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () async {
                  final review = reviewController.text.trim();
                  Navigator.pop(dialogContext);

                  try {
                    await providerProfileCubit.rateProvider(
                      providerId: widget.providerId!,
                      rating: selectedRating,
                      review: review,
                    );
                    if (!mounted) return;
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text("Review added successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } catch (e) {
                    debugPrint("❌ Error submitting review: $e");
                    if (!mounted) return;
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      SnackBar(
                        content: Text("Failed to submit review: $e"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("send"),
              ),
            ],
          );
        },
      ),
    );
  }
}