import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class EditProfileLabourer extends StatelessWidget {
  const EditProfileLabourer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 353.w,
                height: 500.h,
                decoration: BoxDecoration(
                  color: Color(0xFFF3F2F2),
                  borderRadius: BorderRadius.circular(18.r),
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
                          CustomTextFormFiled(
                            hintText: "hh",
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
                            "Email",
                            style: TextStyles.font16PrimaryColorW600,
                          ),
                          CustomTextFormFiled(
                            hintText: "hh",
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
                            "Phone Number ",
                            style: TextStyles.font16PrimaryColorW600,
                          ),
                          CustomTextFormFiled(
                            hintText: "hh",
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
                            "Location ",
                            style: TextStyles.font16PrimaryColorW600,
                          ),
                          CustomTextFormFiled(
                            hintText: "hh",
                            borderSide: BorderSide(
                              width: 0.1,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(2),
                            ),
                          ),
                          Gap(20),
                        ],
                      ),
                    ),
                    Text(
                      "Choose sub category :",
                      style: TextStyles.font14PrimaryColorW700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
