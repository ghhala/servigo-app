import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class ServiceCategoryCard extends StatelessWidget {
  final String name;
  final String image;

  const ServiceCategoryCard({super.key, required this.name, required this.image, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Container(
          width: 100.w,
          height: 120.h,
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
        child: Column(
          children: [
            Image.asset(image),
            Gap(16),
            Text(
              name,
              style: TextStyles.onCard(
                context,
                TextStyles.font14PrimaryColorW700.copyWith(fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
