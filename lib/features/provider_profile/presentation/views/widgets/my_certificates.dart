import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MyCertificates extends StatelessWidget {
  // استقبال مصفوفة الشهادات الجاهزة من الـ API
  final List<dynamic> certificatesList;

  const MyCertificates({super.key, required this.certificatesList});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353.w,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.card_membership, size: 20.sp, color: Theme.of(context).primaryColor),
                Gap(6.w),
                Text(
                  "His Certificates",
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Gap(12.h),
            
            certificatesList.isEmpty
                ? Center(
                    child: Text(
                      "No certificates uploaded yet.",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  )
                : SizedBox(
                    height: 90.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: certificatesList.length,
                      itemBuilder: (context, index) {
                        // الرابط هنا يأتي كامل ومعدل جاهز بـ 10.0.2.2 ولا يحتاج أي إضافة!
                        String fullCertificateUrl = certificatesList[index]['file_path'] ?? '';

                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.network(
                              fullCertificateUrl,
                              width: 120.w, 
                              height: 90.h,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  width: 120.w,
                                  color: Colors.grey.shade200,
                                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 120.w,
                                  color: Colors.grey.shade300,
                                  child: Icon(Icons.broken_image, color: Colors.grey.shade600),
                                );
                              },
                            ),
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