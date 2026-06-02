import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/filter/domain/entities/provider_entity.dart';
import 'package:servi_go_app/features/filter/domain/entities/sub_service_entity.dart';
import 'package:servi_go_app/features/filter/presentation/views/filter_bottom_sheet.dart';
import 'package:servi_go_app/features/filter/presentation/views/widgets/provider_card_widget.dart';

class FilterView extends StatefulWidget {
  const FilterView({super.key});

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  // ✅ State
  bool isFiltered = false;
  String? sortBy;

  final List<ProviderEntity> providers = [
    const ProviderEntity(
      id: 1,
      name: 'jon doe',
      photo: null,
      subServiceName: 'تنظيف منازل',
      locationName: 'Hama',
      workType: 'mobile',
      minPrice: 10000,
      maxPrice: 30000,
      avgRating: 4.8,
      isAvailable: true,
    ),
    const ProviderEntity(
      id: 2,
      name: 'Sara Ahmad',
      photo: null,
      subServiceName: 'تنظيف مكاتب',
      locationName: 'Homs',
      workType: 'both',
      minPrice: 15000,
      maxPrice: 40000,
      avgRating: 4.6,
      isAvailable: true,
    ),
  ];

  // ✅ Sort By Options
  final List<Map<String, String>> _sortOptions = const [
    {'label': 'price ↑', 'value': 'price'},
    {'label': 'rating ↓', 'value': 'rating'},
    {'label': 'location', 'value': 'location'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        withScaffold: false,
        padding: EdgeInsetsGeometry.only(top: 65.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Filter Icon ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 35.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: IconButton(
                      onPressed: _openFilter,
                      icon: const Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 23,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Gap(12.h),

            // ✅ Sort By — يظهر فقط بعد الضغط على Apply
            if (isFiltered) _buildSortBy(),

            // ── Label ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                isFiltered ? 'Results ' : ' Top 5 providers',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),

            // ── List ──
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: providers.length,
              separatorBuilder: (context, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                return ProviderCardWidget(
                  provider: providers[index],
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/provider-profile',
                      arguments: providers[index].id,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Sort By Widget
  Widget _buildSortBy() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sort By:',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(height: 6.h),
          Row(
            children: _sortOptions.map((o) {
              final value = o['value']!;
              final isSelected = sortBy == value;
              return GestureDetector(
                onTap: () => setState(() => sortBy = value),
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF6C5CE7)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF6C5CE7)
                          : Colors.grey.shade300,
                    ),
                  ),
                  child: Text(
                    o['label']!,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
          // ── Divider ──
          Divider(color: Colors.grey.shade200, height: 1),
        ],
      ),
    );
  }

  // ✅ فتح الفلتر
  void _openFilter() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => FilterBottomSheet(
        subServices: [
          const SubServiceEntity(id: 1, name: 'تنظيف منازل'),
          const SubServiceEntity(id: 2, name: 'تنظيف مكاتب'),
          const SubServiceEntity(id: 3, name: 'تنظيف سيارات'),
        ],
        onApply:
            ({
              required subServiceId,
              minPrice,
              maxPrice,
              rating,
              availability,
              workType,
            }) {
              // ✅ بعد Apply يظهر Sort By
              setState(() {
                isFiltered = true;
                sortBy = null; // reset الترتيب عند كل فلتر جديد
              });
            },
      ),
    );
  }
}
