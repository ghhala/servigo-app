import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/home/data/models/home_response_model.dart';

class SubCategoryDropdown extends StatelessWidget {
  final List<SubService> subServices;
  final int? selectedId;
  final ValueChanged<int?> onChanged;

  const SubCategoryDropdown({
    super.key,
    required this.subServices,
    required this.selectedId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // 👈 هنا يتم التحقق ديناميكياً إذا كانت لغة التطبيق الحالية هي العربية
    final bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isArabic ? "اختر الفئة الفرعية :" : "Choose sub category :",
          style: TextStyles.onCard(context, TextStyles.font14PrimaryColorW700),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<int>(
          value: selectedId,
          hint: Text(
            isArabic ? "اختر الفئة" : "Choose sub category",
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            filled: true,
            fillColor: const Color(
              0xFFF5F5F5,
            ), // لون الخلفية المتناسق مع تصميمكِ
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  BorderSide.none, // إخفاء الحواف الخارجية ليطابق حقول التصميم
            ),
          ),
          items: subServices.map((SubService service) {
            return DropdownMenuItem<int>(
              value: service.id, // برمجياً نمرر الـ id للسيرفر عند الاختيار
              child: Text(
                // 👈 هنا تم حل مشكلة الـ Null وحماية النصوص بناءً على اللغة الحالية ليتلاشى الخطأ الأحمر
                isArabic ? (service.nameAr ?? '') : (service.nameEn ?? ''),
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
