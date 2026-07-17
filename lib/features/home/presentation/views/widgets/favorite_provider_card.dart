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

  String get _firstLetter => providerName.trim().isNotEmpty
      ? providerName.trim()[0].toUpperCase()
      : '?';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---------------- IMAGE ----------------
          SizedBox(
            height: 90.h,
            width: double.infinity,
            child: imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color: const Color(0xFFF3F2F2),
                        child: const Center(
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        _buildFallbackAvatar(),
                  )
                : _buildFallbackAvatar(),
          ),

          // ---------------- TEXT ----------------
          Padding(
            padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  providerName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.onCard(
                    context,
                    TextStyles.font14PrimaryColorW700.copyWith(fontSize: 13.sp),
                  ),
                ),
                Gap(4.h),

                // Main service
                if (mainService.isNotEmpty)
                  Row(
                    children: [
                      Icon(
                        Icons.category_outlined,
                        size: 12.sp,
                        color: Colors.grey[500],
                      ),
                      Gap(4.w),
                      Expanded(
                        child: Text(
                          mainService,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                // Sub service
                if (subService.isNotEmpty) ...[
                  Gap(2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.build_outlined,
                        size: 12.sp,
                        color: Colors.grey[500],
                      ),
                      Gap(4.w),
                      Expanded(
                        child: Text(
                          subService,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      color: Colors.deepPurpleAccent,
      alignment: Alignment.center,
      child: Text(
        _firstLetter,
        style: TextStyle(
          fontSize: 26.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
