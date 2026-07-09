import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';

class FavoriteProviderCard extends StatelessWidget {
  final String providerName;
  final String imageUrl;
  final String mainService;
  final String subService;

  const FavoriteProviderCard({
    super.key,
    required this.providerName,
    required this.imageUrl,
    required this.mainService,
    required this.subService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: 130.w,
        height: 128.h,
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        width: 50.w,
                        height: 50.h,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          debugPrint("FAVORITE IMAGE ERROR => $imageUrl");
                          debugPrint("FAVORITE IMAGE ERROR DETAILS => $error");
                          return Icon(
                            Icons.person,
                            size: 50.r,
                          );
                        },
                      )
                    : Icon(
                        Icons.person,
                        size: 50.r,
                      ),
              ),
              Gap(6),
              Row(
                children: [
                  Text(
                    "Name: ",
                    style: TextStyles.onCard(
                      context,
                      TextStyles.font8PrimaryColorW700,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      providerName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.onCard(
                        context,
                        TextStyles.font8PrimaryColorW700.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(3),
              Row(
                children: [
                  Text(
                    "Service: ",
                    style: TextStyles.onCard(
                      context,
                      TextStyles.font8PrimaryColorW700,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      mainService,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.onCard(
                        context,
                        TextStyles.font8PrimaryColorW700.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(3),
              Row(
                children: [
                  Text(
                    "Type: ",
                    style: TextStyles.onCard(
                      context,
                      TextStyles.font8PrimaryColorW700,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      subService,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.onCard(
                        context,
                        TextStyles.font8PrimaryColorW700.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
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