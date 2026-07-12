import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/utils/styles.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/custom_container.dart';
import 'package:servi_go_app/features/provider_profile/presentation/views/widgets/video_player_widget.dart';

class MyPortfolio extends StatelessWidget {
  final List<Map<String, dynamic>> portfolioList;

  const MyPortfolio({super.key, required this.portfolioList});

  
  void _openVideoPlayer(BuildContext context, String videoUrl) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 50.h),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayerWidget(videoUrl: videoUrl),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 353.w,
      height: 175.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.import_contacts, size: 18, color: Colors.blueGrey),
                Gap(5.w),
                Text(
                  "My Portfolio",
                  style: TextStyles.onCard(
                    context,
                    TextStyles.font12PrimaryColorW600,
                  ),
                ),
              ],
            ),
            Gap(10.h),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: portfolioList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = portfolioList[index];
                  final fileUrl = item['file_path'] ?? '';
                  final fileType = item['file_type'] ?? 'image';
                  final description = item['description'] ?? '';
                  final isVideo = fileType == 'video';

                  return Padding(
                    padding: EdgeInsets.only(right: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ── عرض الصورة أو thumbnail الفيديو ──
                        GestureDetector(
                          onTap: isVideo
                              ? () => _openVideoPlayer(context, fileUrl)
                              : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: isVideo
                                // ✅ الفيديو: container أسود مع أيقونة play
                                ? Container(
                                    width: 75.w,
                                    height: 75.h,
                                    color: Colors.black87,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        const Icon(
                                          Icons.play_circle_filled,
                                          color: Colors.white,
                                          size: 36,
                                        ),
                                        Positioned(
                                          bottom: 4,
                                          right: 4,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 4,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: const Text(
                                              'VIDEO',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                // ✅ الصورة: Image.network
                                : Image.network(
                                    fileUrl,
                                    width: 75.w,
                                    height: 75.h,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 75.w,
                                        height: 75.h,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.broken_image,
                                          color: Colors.grey,
                                        ),
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: 75.w,
                                        height: 75.h,
                                        color: Colors.grey[200],
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ),
                        Gap(6.h),
                        SizedBox(
                          width: 75.w,
                          child: Text(
                            description.isNotEmpty
                                ? description
                                : (isVideo ? "Video" : "Project"),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}