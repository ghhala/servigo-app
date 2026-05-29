import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/Profile_photo_widget.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/holiday_days_widget.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/price_widget.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/protfolio_widget.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/sub_category_picker.dart';
import 'package:servi_go_app/features/profile/presentation/views/widgets/working_hours_picker.dart';

class EditProfileLabourer extends StatelessWidget {
  final String userType;
  final Map<String, dynamic>? userData;
  const EditProfileLabourer({super.key, this.userData, required this.userType});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final containerColor = isDark ? theme.cardColor : const Color(0xFFF3F2F2);
    final dividerColor = theme.dividerColor;
    final onSurface = theme.colorScheme.onSurface;
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(top: 45.h),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ProfilePhotoWidget(),
                Gap(10),
                Container(
                  width: 353.w,
                  height: 530.h,
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Account Info",
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font16BlackW700,
                            ),
                          ),
                        ),
                        Divider(color: dividerColor, thickness: 0.8),
                        Gap(11),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Full Name",
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font16PrimaryColorW600,
                                ),
                              ),
                              CustomTextFormFiled(
                                hintText:
                                    userData?['full_name'] as String? ?? "hala",
                                borderSide: BorderSide(
                                  width: 0.1,
                                  color: dividerColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              Gap(20),
                              Text(
                                "Email",
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font16PrimaryColorW600,
                                ),
                              ),
                              CustomTextFormFiled(
                                hintText: userData?['email'] as String? ?? "",
                                borderSide: BorderSide(
                                  width: 0.1,
                                  color: dividerColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              Gap(20),
                              Text(
                                "Phone Number ",
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font16PrimaryColorW600,
                                ),
                              ),
                              CustomTextFormFiled(
                                hintText: userData?['phone'] as String? ?? "",
                                borderSide: BorderSide(
                                  width: 0.1,
                                  color: dividerColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              Gap(20),
                              Text(
                                "Location ",
                                style: TextStyles.onCard(
                                  context,
                                  TextStyles.font16PrimaryColorW600,
                                ),
                              ),
                              CustomTextFormFiled(
                                hintText:
                                    userData?['location'] as String? ?? "",
                                borderSide: BorderSide(
                                  width: 0.1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              Gap(20),
                              Text(
                                "about_me ",
                                style: TextStyles.font16PrimaryColorW600,
                              ),
                              CustomTextFormFiled(
                                hintText: "Describe yourself in a few words",
                                hintStyle: TextStyles.font11BlackW400,

                                borderSide: BorderSide(
                                  width: 0.1,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              Gap(20),
                              Text(
                                "about_me ",
                                style: TextStyles.font16PrimaryColorW600,
                              ),
                              CustomTextFormFiled(
                                hintText: "Describe yourself in a few words",
                                hintStyle: TextStyles.font11BlackW400,

                                borderSide: BorderSide(
                                  width: 0.1,
                                  color: dividerColor,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(2),
                                ),
                              ),
                              Gap(20),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Text(
                            "Choose sub category :",
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font14PrimaryColorW700,
                            ),
                          ),
                        ),
                        Gap(4),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: CustomSubCategoryPicker(
                            items: const [
                              "House Cleaning",
                              "Car Cleaning",
                              "Water Heater Installation",
                              "Pipe Repair",
                              "Office Cleaning",
                              "Lighting Installation",
                            ],
                            initialValue: "electrical",
                            onSelected: (value) {},
                          ),
                        ),
                        Gap(20),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Text(
                            "Specify the holiday days :",
                            style: TextStyles.onCard(
                              context,
                              TextStyles.font14PrimaryColorW700,
                            ),
                          ),
                        ),
                        HolidayDaysWidget(),
                        Gap(14),
                        CustomTimePicker(
                          onTimeChanged:
                              (startHour, startPeriod, endHour, endPeriod) {
                                print(
                                  'From: $startHour:00 $startPeriod  To: $endHour:00 $endPeriod',
                                );
                              },
                        ),
                        Gap(20),
                        Text(
                          "Set the price for the services :",
                          style: TextStyles.onCard(
                            context,
                            TextStyles.font14PrimaryColorW700,
                          ),
                        ),
                        PriceWidget(),
                        Gap(47),
                        Text(
                          " Security ",
                          style: TextStyles.onCard(
                            context,
                            TextStyles.font16BlackW700,
                          ),
                        ),
                        Divider(color: dividerColor, thickness: 0.8),
                        Gap(10),
                        Row(
                          children: [
                            Icon(
                              Icons.lock_outline,
                              size: 20,
                              color: onSurface,
                            ),
                            Gap(10),
                            Text(
                              "Change Password",
                              style: TextStyles.onCard(
                                context,
                                TextStyles.font16PrimaryColorW600,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: onSurface,
                            ),
                          ],
                        ),
                        Gap(49),
                      ],
                    ),
                  ),
                ),
                Gap(20),
                MyPortfolioSection(),

                Gap(35),

                CustomButton(
                  width: 205.w,
                  height: 30.h,
                  title: "Update Info",
                  textstyle: TextStyles.font20White800.copyWith(
                    fontSize: 17.sp,
                  ),
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.kHome,
                      extra: {"userType": userType, "userData": userData},
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
