import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/core/widgets/langague_theme_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_cubit.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_state.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/container_widget.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/custom_container.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/my_protifolio.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/my_certificates.dart';

class ProfileLabourerView extends StatefulWidget {
  const ProfileLabourerView({super.key});

  @override
  State<ProfileLabourerView> createState() => _ProfileLabourerViewState();
}

class _ProfileLabourerViewState extends State<ProfileLabourerView> {
  @override
  void initState() {
    super.initState();
    // جلب بيانات الحساب فور فتح الشاشة لضمان عدم بقائها فارغة
    context.read<ProviderProfileCubit>().fetchProviderProfile();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        withScaffold: false,
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 50.h),
        child: BlocBuilder<ProviderProfileCubit, ProviderProfileState>(
          builder: (context, state) {

            // ── Loading ──
            if (state is ProviderProfileLoading) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
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

              // ── أيام العمل ──
              const allDays = [
                'sunday', 'monday', 'tuesday',
                'wednesday', 'thursday', 'friday', 'saturday',
              ];
              final offDays = provider?.offDays ?? [];
              final workingDays = allDays
                  .where((d) => !offDays.contains(d))
                  .map((d) => d[0].toUpperCase() + d.substring(1))
                  .join(', ');

              // ── الصورة الشخصية ──
              final avatarUrl = getCorrectImageUrl(user?.photo);

              // ── متوسط التقييم ──
              final finalRating = double.tryParse(
                    profileData?.avgRating?.toString() ?? '0',
                  ) ?? 0.0;

              // ── Portfolio ──
              final portfolioItems = (profileData?.portfolio ?? [])
                  .where((e) => e.filePath != null)
                  .map((e) => {
                        'file_path': getCorrectImageUrl(e.filePath),
                        'file_type': e.fileType ?? 'image',
                        'description': e.description ?? '',
                      })
                  .toList();

              // ── Certificates ──
              final certificateItems = (profileData?.certificates ?? [])
                  .where((e) => e.filePath != null)
                  .map((e) => {
                        'file_path': getCorrectImageUrl(e.filePath),
                      })
                  .toList();

           
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const LangagueThemeWidget(),
                    Gap(20.h), // تقليل الـ Gap العلوي لأن التمرير يأخذ مساحة مريحة الآن

                  
                    CustomContainer(
                      width: 360.w,
                      height: 350.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15).r,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: avatarUrl.isNotEmpty
                                  ? NetworkImage(avatarUrl)
                                  : const AssetImage(
                                          "assets/images/avatar2.jpg")
                                      as ImageProvider,
                            ),
                            Gap(10.h),
                            Text(
                              user?.name ?? "No Name",
                              style: TextStyles.onCard(
                                context,
                                TextStyles.font16PrimaryColorW600
                                    .copyWith(fontSize: 18.sp),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(5.h),
                            Text(
                              "${provider?.mainServiceName ?? ''} | ${provider?.subServiceName ?? ''}",
                              style: TextStyles.onCard(
                                context,
                                TextStyles.font12PrimaryColorW600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                TextStyles.font12PrimaryColorW600
                                    .copyWith(fontSize: 13.sp),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(20.h),

                            // ── Stats Row 1: Rating + Work Type ──
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8).r,
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
                                      text: provider?.workType ??
                                          "Both(Fixed & Mobile)",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(10.h),

                            // ── Stats Row 2: Available + Overnight ──
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8).r,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ContainerWidget(
                                      image: "assets/images/convenience (1).png",
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
                          ],
                        ),
                      ),
                    ),
                    Gap(20.h),

                    // ── About Him ──
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
                                Image.asset("assets/images/about_him_icon.png"),
                                Gap(5.w),
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
                          Gap(2.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              provider?.aboutMe ??
                                  "No info written by provider.",
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
                            horizontal: 8.w, vertical: 8.h),
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
                                Image.asset("assets/images/about_him_icon.png"),
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
      // 1. جلب القيم وتحويلها لنصوص نظيفة من أي مسافات
      String minStr = provider?.minPrice?.toString().trim() ?? '0';
      String maxStr = provider?.maxPrice?.toString().trim() ?? '0';

      // 2. إذا كان النص يحتوي على نقطة عشرية (مثل 1.00 أو 100.00)، نأخذ الجزء الصحيح فقط قبل النقطة
      if (minStr.contains('.')) {
        minStr = minStr.split('.').first;
      }
      if (maxStr.contains('.')) {
        maxStr = maxStr.split('.').first;
      }

    
      final int minPrice = int.tryParse(minStr) ?? 0;
      final int maxPrice = int.tryParse(maxStr) ?? 0;

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

                    // ── Certificates ──
                    if (certificateItems.isNotEmpty) ...[
                      MyCertificates(certificatesList: certificateItems),
                      Gap(20.h),
                    ],

                    // ── Customer Reviews and Ratings ──
                    CustomContainer(
                      width: 353.w,
                      height: 134.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset("assets/images/reviews_icon.png"),
                                Text(
                                  " Customer Reviews and Ratings",
                                  style: TextStyles.onCard(
                                    context,
                                    TextStyles.font12PrimaryColorW600,
                                  ),
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
                                : Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 15.r,
                                        backgroundImage: const AssetImage(
                                            "assets/images/user_avatar.jpg"),
                                      ),
                                      Gap(8.w),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Jane Smith",
                                            style: TextStyles.onCard(
                                              context,
                                              TextStyles.font12BlackW400
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          ),
                                          Gap(4.h),
                                          Text(
                                            "Great service! Highly recommend.",
                                            style: TextStyles.onCard(
                                              context,
                                              TextStyles.font12BlackW400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      CustomButton(
                                        width: 50.w,
                                        height: 23.h,
                                        title: "Report",
                                        textstyle: TextStyles.font11WhiteW500
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                        onTap: () {},
                                      ),
                                    ],
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
    );
  }
}