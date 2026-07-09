import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class ServiceCategoryCard extends StatelessWidget {
  final String name;
  final String image;

  const ServiceCategoryCard({
    super.key,
    required this.name,
    required this.image,
  });

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 50.w,
              height: 50.h,
              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        debugPrint("SERVICE IMAGE ERROR => $image");
                        debugPrint("SERVICE IMAGE ERROR DETAILS => $error");
                        return Image.asset(
                          "assets/images/test.png",
                          fit: BoxFit.contain,
                        );
                      },
                    )
                  : Image.asset(
                      "assets/images/test.png",
                      fit: BoxFit.contain,
                    ),
            ),
            const Gap(12),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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