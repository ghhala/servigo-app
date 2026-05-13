import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
                          children: [
                            CustomTextFormFiled(
                              hintText: "20.000",
                              hintStyle: TextStyles.font12PrimaryColorW600,
                              textInputType: TextInputType.number,
                              fillColor: Color(0xFFD9D9D9),
                              width: 100.w,
                              height: 20.h,
                              borderSide: BorderSide(
                                width: 0.1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            Gap(2),
                            Text(
                              "SYP",
                              style: TextStyles.font12PrimaryColorW600.copyWith(
                                fontSize: 10,
                              ),
                            ),
                            Gap(5),
                            Text("-"),
                            Gap(8),
                            CustomTextFormFiled(
                              hintText: "20.000",
                              hintStyle: TextStyles.font12PrimaryColorW600,
                              textInputType: TextInputType.number,
                              fillColor: Color(0xFFD9D9D9),
                              width: 100.w,
                              height: 20.h,
                              borderSide: BorderSide(
                                width: 0.1,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            Gap(5),
                            Text(
                              "SYP",
                              style: TextStyles.font12PrimaryColorW600.copyWith(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        );
  }
}