import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class ProviderRatingCard extends StatelessWidget {
  final String providerName;
  final String imageUrl;
  final String serviceType;
  final double rating;
  const ProviderRatingCard({
    super.key,
    required this.providerName,
    required this.imageUrl,
    required this.serviceType,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: 130.w,
        height: 128.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Image.asset(imageUrl),
              Gap(6),
              Row(
                children: [
                  Text("Name:", style: TextStyles.font8PrimaryColorW700),

                  Text(
                    providerName,
                    style: TextStyles.font8PrimaryColorW700.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Gap(3),
              Row(
                children: [
                  Text(
                    "Type of service :",
                    style: TextStyles.font8PrimaryColorW700,
                  ),

                  Expanded(
                    child: Text(
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                      serviceType,
                      style: TextStyles.font8PrimaryColorW700.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(3),
              Row(
                children: [
                  Text("Evaluation", style: TextStyles.font8PrimaryColorW700),

                  Text(
                    rating.toString(),
                    style: TextStyles.font8PrimaryColorW700.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
