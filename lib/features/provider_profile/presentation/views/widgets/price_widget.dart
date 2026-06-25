import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 قمنا بإضافة هذه المكتبة للتحكم بمدخلات النص
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/auth/presentation/views/widgets/custom_text_form_filed.dart';

class PriceWidget extends StatelessWidget {
  // 1. إضافة الـ Callback لاستقبال التغييرات وتمريرها للشاشة الأساسية
  final Function(String minPrice, String maxPrice) onPriceChanged;

  // سنقوم بتعريف متغيرين محليين لتخزين القيم أثناء الكتابة
  static String _currentMin = '';
  static String _currentMax = '';

  const PriceWidget({super.key, required this.onPriceChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fillColor = isDark ? theme.cardColor : const Color(0xFFD9D9D9);
    final borderSide = BorderSide(width: 0.1, color: theme.dividerColor);
    final labelStyle = TextStyles.onCard(
      context,
      TextStyles.font12PrimaryColorW600,
    ).copyWith(fontSize: 10);
    final textColor = theme.colorScheme.onSurface;

    return Row(
      children: [
        // ── حقل السعر الأدنى (Minimum Price) ──
        CustomTextFormFiled(
          hintText: "10000", // 👈 تعديل الـ Hint ليصبح رقماً صحيحاً بدون نقطة ليفهم المستخدم التنسيق
          hintStyle: TextStyles.font12PrimaryColorW600,
          textInputType: TextInputType.number,
          // 👇 هذا الفلتر يمنع كتابة أي شيء عدا الأرقام (يمنع الفاصلة والنقطة تماماً)
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          fillColor: fillColor,
          width: 100.w,
          height: 20.h,
          borderSide: borderSide,
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          onChanged: (value) {
            _currentMin = value ?? ''; 
            onPriceChanged(_currentMin, _currentMax);
          },
        ),
        const Gap(2),
        Text(
          "SYP",
          style: labelStyle,
        ),
        const Gap(5),
        Text(
          "-",
          style: TextStyle(color: textColor),
        ),
        const Gap(8),
       
        CustomTextFormFiled(
          hintText: "20000", // 👈 تعديل الـ Hint ليصبح رقماً صحيحاً بدون نقطة
          hintStyle: TextStyles.font12PrimaryColorW600,
          textInputType: TextInputType.number,
          // 👇 يمنع إدخال الرموز والنقاط العشرية لمنع تشوه الرقم في قاعدة البيانات
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          fillColor: fillColor,
          width: 100.w,
          height: 20.h,
          borderSide: borderSide,
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          onChanged: (value) {
            _currentMax = value ?? ''; 
            onPriceChanged(_currentMin, _currentMax);
          },
        ),
        const Gap(5),
        Text(
          "SYP",
          style: labelStyle,
        ),
      ],
    );
  }
}