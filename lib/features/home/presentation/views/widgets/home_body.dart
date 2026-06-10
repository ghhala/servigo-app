import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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

  const HomeBody({super.key, required this.userType});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    super.initState();
    // 🚀 بمجرد أن يفتح المستخدم تبويب الهوم، سينطلق هذا السطر تلقائياً ويجلب البيانات المحدثة!
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
            // 💡 جلب رابط الصورة المخزن كاش محلياً للحساب الحالي
            final String userImage = PrefHelper.getUserImage();

            final String firstLetter = userName.trim().isNotEmpty
                ? userName.trim()[0].toUpperCase()
                : 'U';

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LangagueThemeWidget(),
                  const Gap(16),
                  (widget.userType == 'labourer')
                      ? CircleAvatar(
                          radius: 45.r,
                          backgroundImage: const AssetImage("assets/images/avatar2.jpg"),
                        )
                      : CircleAvatar(
                          radius: 35.r,
                          // 💡 إذا كانت الصورة فارغة، نضع اللون البنفسجي، وإذا وُجدت نضع خلفية رمادية خفيفة للحماية
                          backgroundColor: userImage.isEmpty 
                              ? Colors.deepPurpleAccent 
                              : const Color(0xFFF3F2F2),
                          // 💡 عرض صورة الشبكة في حال توفر الرابط مع كسر الكاش لمنع التجميد المعتاد بالفلاتر
                          backgroundImage: userImage.isNotEmpty
                              ? NetworkImage('$userImage?v=${DateTime.now().millisecondsSinceEpoch}')
                              : null,
                          // 💡 إذا لم تكن هناك صورة، نعرض أول حرف من الاسم كبديل أنيق
                          child: userImage.isEmpty
                              ? Text(
                                  firstLetter,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                )
                              : null,
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
                              return ServiceCategoryCard(
                                name: service.nameEn ?? 'Service',
                                image: service.photo ?? "assets/images/test.png",
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