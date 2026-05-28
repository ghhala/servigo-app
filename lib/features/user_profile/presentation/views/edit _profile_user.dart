import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/core/widgets/change_password_page%20.dart';
import 'package:servi_go_app/core/widgets/custom_button.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class EditProfileUser extends StatelessWidget {
  const EditProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        padding: EdgeInsets.only(top: 170.h),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Container(
                width: 353.w,
                height: 400.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF3F2F2),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Account Info",
                        style: TextStyles.font16BlackW700,
                      ),
                    ),
                    Divider(color: Colors.black, thickness: 0.8),
                    Gap(11),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Full Name",
                            style: TextStyles.font16PrimaryColorW600,
                          ),
                          CustomTextFormFiled(hintText: "Hala Ghassa"),
                          Gap(20),
                          Text(
                            "Email",
                            style: TextStyles.font16PrimaryColorW600,
                          ),
                          CustomTextFormFiled(hintText: "ghhala02@gmail.com"),
                          Gap(20),
                          Text(
                            "Phone Number ",
                            style: TextStyles.font16PrimaryColorW600,
                          ),
                          CustomTextFormFiled(hintText: "09767644257"),
                        ],
                      ),
                    ),
                    Gap(30),
                    Text(" Security ", style: TextStyles.font16BlackW700),
                    Divider(color: Colors.black, thickness: 0.8),
                    Gap(10),
                    Row(
                      children: [
                        Icon(Icons.lock_outline, size: 20),
                        Gap(10),
                        Text(
                          "Change Password",
                          style: TextStyles.font16PrimaryColorW600,
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordPage(),
                              ),
                            );
                          },
                          child: Icon(Icons.arrow_forward_ios, size: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Gap(60),
              CustomButton(
                width: 140.w,
                height: 30.h,
                textstyle: TextStyles.font11WhiteW500.copyWith(fontSize: 15.sp),
                title: "Update Info",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
