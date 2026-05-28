import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fillColor =
        isDark ? theme.cardColor : const Color(0xFFD9D9D9);
    final borderSide = BorderSide(width: 0.1, color: theme.dividerColor);
    final labelStyle = TextStyles.onCard(
      context,
      TextStyles.font12PrimaryColorW600,
    ).copyWith(fontSize: 10);
    final textColor = theme.colorScheme.onSurface;
    return Row(
                          children: [
                            CustomTextFormFiled(
                              hintText: "20.000",
                              hintStyle: TextStyles.font12PrimaryColorW600,
                              textInputType: TextInputType.number,
                              fillColor: fillColor,
                              width: 100.w,
                              height: 20.h,
                              borderSide: borderSide,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            Gap(2),
                            Text(
                              "SYP",
                              style: labelStyle,
                            ),
                            Gap(5),
                            Text(
                              "-",
                              style: TextStyle(color: textColor),
                            ),
                            Gap(8),
                            CustomTextFormFiled(
                              hintText: "20.000",
                              hintStyle: TextStyles.font12PrimaryColorW600,
                              textInputType: TextInputType.number,
                              fillColor: fillColor,
                              width: 100.w,
                              height: 20.h,
                              borderSide: borderSide,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                            Gap(5),
                            Text(
                              "SYP",
                              style: labelStyle,
                            ),
                          ],
                        );
  }
}