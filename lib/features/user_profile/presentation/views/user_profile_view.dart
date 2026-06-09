import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/home/presentation/view_models/home/cubit/home_cubit.dart';
import 'package:servi_go_app/features/user_profile/presentation/view_models/user_profile/user_profile_cubit.dart';
import 'package:servi_go_app/features/user_profile/presentation/view_models/user_profile/user_profile_state.dart';

class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.34,
        ),
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileSuccess) {
              final user = state.userData;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Container(
                      width: 435.w,
                      height: 250.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50.r,

                            backgroundImage: user.photo != null
                                ? NetworkImage(user.photo!)
                                : null,
                            child: user.photo == null
                                ? Text(
                                    user.name?[0].toUpperCase() ?? "U",
                                    style: TextStyle(
                                      fontSize: 28.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            user.name ?? "لا يوجد اسم",
                            style: TextStyles.font18BlackW500.copyWith(
                              fontSize: 18.sp,
                            ),
                          ),
                          Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone, size: 17.sp),
                              Gap(5),
                              Text(user.phone ?? "لا يوجد رقم هاتف"),
                            ],
                          ),
                          Gap(5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.email, size: 17.sp),
                              Gap(5),

                              const Text("user@servigo.com"),
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
                    title: "edit profile",
                    textstyle: TextStyles.font11WhiteW500.copyWith(
                      fontSize: 13.sp,
                    ),
                    onTap: () async {
                      final userProfileCubit =
                          BlocProvider.of<UserProfileCubit>(context);
                      final homeCubit = BlocProvider.of<HomeCubit>(context);

                      await GoRouter.of(
                        context,
                      ).push(AppRouter.kEditeProfile, extra: user);

                      userProfileCubit.fetchUserProfile();
                      homeCubit.fetchHomeData();
                    },
                  ),
                ],
              );
            } else if (state is UserProfileFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "خطأ: ${state.errorMessage}",
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(10),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<UserProfileCubit>(
                          context,
                        ).fetchUserProfile();
                      },
                      child: const Text("إعادة المحاولة"),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: Text("جاري تحضير البيانات..."));
          },
        ),
      ),
    );
  }
}
