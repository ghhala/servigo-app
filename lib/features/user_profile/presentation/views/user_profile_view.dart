import 'dart:ui';

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

  String _formatImageUrl(String? url) {
    if (url == null || url.isEmpty) return '';
    if (url.contains('localhost')) {
      return url.replaceAll('localhost', '10.0.2.2');
    }
    return url;
  }

  // Single soft-blurred gradient blob used for the decorative corners.
  Widget _blob({required double size, required List<Color> colors}) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.30,
        ),
        child: BlocBuilder<UserProfileCubit, UserProfileState>(
          builder: (context, state) {
            if (state is UserProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserProfileSuccess) {
              final user = state.userData;

              final String imageUrl = _formatImageUrl(user.photo);

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: 435.w,
                        height: 260.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Stack(
                          children: [
                            // ---- top-left blob ----
                            Positioned(
                              top: -50.h,
                              left: -45.w,
                              child: _blob(
                                size: 190.w,
                                colors: [
                                  const Color(0xFF6C5CE7),
                                  Colors.blue.shade300,
                                ],
                              ),
                            ),
                            // ---- top-right blob ----
                            Positioned(
                              top: -35.h,
                              right: -55.w,
                              child: _blob(
                                size: 170.w,
                                colors: [
                                  Colors.blue.shade200,
                                  const Color(0xFF6C5CE7).withOpacity(0.7),
                                ],
                              ),
                            ),
                            // ---- bottom-right blob ----
                            Positioned(
                              bottom: -55.h,
                              right: -40.w,
                              child: _blob(
                                size: 190.w,
                                colors: [
                                  Colors.blue.shade300,
                                  const Color(0xFF6C5CE7),
                                ],
                              ),
                            ),
                            // ---- bottom-left blob ----
                            Positioned(
                              bottom: -45.h,
                              left: -50.w,
                              child: _blob(
                                size: 160.w,
                                colors: [
                                  const Color(0xFF6C5CE7).withOpacity(0.75),
                                  Colors.blue.shade200,
                                ],
                              ),
                            ),
                            // ---- actual profile content on top ----
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 48.r,
                                  backgroundColor: imageUrl.isEmpty
                                      ? Colors.deepPurpleAccent
                                      : const Color(0xFFF3F2F2),
                                  backgroundImage: imageUrl.isNotEmpty
                                      ? NetworkImage(
                                          '$imageUrl?v=${DateTime.now().millisecondsSinceEpoch}',
                                        )
                                      : null,
                                  child: imageUrl.isEmpty
                                      ? Text(
                                          user.name?[0].toUpperCase() ?? "U",
                                          style: TextStyle(
                                            fontSize: 28.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        )
                                      : null,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  user.name ?? "No Name ",
                                  style: TextStyles.font18BlackW500.copyWith(
                                    fontSize: 18.sp,
                                  ),
                                ),
                                const Gap(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.phone, size: 17.sp),
                                    const Gap(5),
                                    Text(user.phone ?? "No Phone Number"),
                                  ],
                                ),
                                const Gap(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.email, size: 17.sp),
                                    const Gap(5),
                                    const Text("user@servigo.com"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(50),
                  CustomButton(
                    width: 140.w,
                    height: 30.h,
                    title: "edit profile",
                    textstyle: TextStyles.font11WhiteW500.copyWith(
                      fontSize: 15.sp,
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
                      child: const Text("try again"),
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
