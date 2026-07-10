import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:servi_go_app/features/filter/presentation/view_models/filter/filter_cubit.dart';
import 'package:servi_go_app/features/filter/presentation/view_models/filter/filter_state.dart';
import 'package:servi_go_app/features/filter/presentation/views/widgets/availability_selector.dart';
import 'package:servi_go_app/features/filter/presentation/views/widgets/price_range_slider.dart';
import 'package:servi_go_app/features/filter/presentation/views/widgets/rating_selector.dart';
import 'package:servi_go_app/features/filter/presentation/views/widgets/sub_service_selector.dart';
import 'package:servi_go_app/features/filter/presentation/views/widgets/work_type_selector.dart';
import '../../domain/entities/sub_service_entity.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<SubServiceEntity>? subServices;

  final int? initialSubServiceId;
  final double? initialMinPrice;
  final double? initialMaxPrice;
  final int? initialRating;
  final String? initialAvailability;
  final String? initialWorkType;

  final Function({
    int? subServiceId,
    double? minPrice,
    double? maxPrice,
    int? rating,
    String? availability,
    String? workType,
  })
  onApply;

  const FilterBottomSheet({
    super.key,
    this.subServices,
    required this.onApply,
    this.initialSubServiceId,
    this.initialMinPrice,
    this.initialMaxPrice,
    this.initialRating,
    this.initialAvailability,
    this.initialWorkType,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? selectedSubServiceId;
  RangeValues priceRange = const RangeValues(0, 100000);
  int? selectedRating;
  String? selectedAvailability;
  String? selectedWorkType;

  static const primary = Color(0xFF6C5CE7);

  @override
  void initState() {
    super.initState();
    selectedSubServiceId = widget.initialSubServiceId;
    priceRange = RangeValues(
      widget.initialMinPrice ?? 0,
      widget.initialMaxPrice ?? 100000,
    );
    selectedRating = widget.initialRating;
    selectedAvailability = widget.initialAvailability;
    selectedWorkType = widget.initialWorkType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // خط السحب العلوي (Handle)
          Container(
            width: 40.w,
            height: 4.h,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // الرأس (Header)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filter',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                TextButton(
                  onPressed: _resetAll,
                  child: const Text('Reset', style: TextStyle(color: primary)),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<FilterCubit, FilterState>(
                    builder: (context, state) {
                      List<SubServiceEntity> availableSubServices =
                          widget.subServices ?? state.subServices;

                      if (availableSubServices.isEmpty &&
                          state.status == FilterStatus.loading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: CircularProgressIndicator(color: primary),
                          ),
                        );
                      }

                      if (availableSubServices.isEmpty &&
                          state.status == FilterStatus.error) {
                        return Center(
                          child: Text(
                            state.errorMessage ?? 'Failed to load sub-services',
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      // عرض قائمة اختيار الخدمات الفرعية
                      return SubServiceSelector(
                        subServices: availableSubServices,
                        selectedId: selectedSubServiceId,
                        onSelect: (id) =>
                            setState(() => selectedSubServiceId = id),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // منزلق تحديد مدى السعر
                  PriceRangeSlider(
                    values: priceRange,
                    onChanged: (v) => setState(() => priceRange = v),
                  ),
                  const SizedBox(height: 20),

                  // اختيار التقييم
                  RatingSelector(
                    selectedRating: selectedRating,
                    onSelect: (v) => setState(() => selectedRating = v),
                  ),
                  const SizedBox(height: 20),

                  // اختيار توفر العامل
                  AvailabilitySelector(
                    selectedValue: selectedAvailability,
                    onSelect: (v) => setState(() => selectedAvailability = v),
                  ),
                  const SizedBox(height: 20),

                  // اختيار نوع العمل
                  WorkTypeSelector(
                    selectedValue: selectedWorkType,
                    onSelect: (v) => setState(() => selectedWorkType = v),
                  ),
                  const SizedBox(height: 24),

                  // أزرار التحكم (إعادة تعيين وتطبيق)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _resetAll,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            side: const BorderSide(color: primary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Reset',
                            style: TextStyle(color: primary),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 2,
                        child: ElevatedButton(
                          onPressed: _applyFilter,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Apply Filter',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _resetAll() {
    setState(() {
      selectedSubServiceId = null;
      priceRange = const RangeValues(0, 100000);
      selectedRating = null;
      selectedAvailability = null;
      selectedWorkType = null;
    });
  }

  void _applyFilter() {
    if (selectedSubServiceId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى اختيار نوع الخدمة الفرعية أولاً'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    widget.onApply(
      subServiceId: selectedSubServiceId,
      minPrice: priceRange.start,
      maxPrice: priceRange.end,
      rating: selectedRating,
      availability: selectedAvailability,
      workType: selectedWorkType,
    );
    Navigator.pop(context);
  }
}
