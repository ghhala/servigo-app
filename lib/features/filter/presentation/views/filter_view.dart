import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:servi_go_app/core/utils/app_router.dart';
import 'package:servi_go_app/core/widgets/app_background.dart';
import 'package:servi_go_app/features/filter/domain/entities/provider_entity.dart';
import 'package:servi_go_app/features/filter/presentation/view_models/filter/filter_cubit.dart';
import 'package:servi_go_app/features/filter/presentation/view_models/filter/filter_state.dart';
import 'package:servi_go_app/features/filter/presentation/views/filter_bottom_sheet.dart';
import 'package:servi_go_app/features/filter/presentation/views/widgets/provider_card_widget.dart';
import '../../data/models/filter_request_model.dart';
import '../../data/models/provider_filter_model.dart';

class FilterView extends StatefulWidget {
  final int mainServiceId;
  final String mainServiceName;

  const FilterView({
    super.key,
    required this.mainServiceId,
    required this.mainServiceName,
  });

  @override
  State<FilterView> createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  bool isFiltered = false;
  String? sortBy;

  int? currentSubServiceId;
  double? currentMinPrice;
  double? currentMaxPrice;
  String? currentRating;
  bool? currentAvailability;
  String? currentWorkType;

  double? _userLat;
  double? _userLng;
  bool _isLoadingLocation = false;

  final List<Map<String, String>> _sortOptions = const [
    {'label': 'price ↑', 'value': 'price'},
    {'label': 'rating ↓', 'value': 'rating'},
    {'label': 'location', 'value': 'location'},
  ];

  @override
  void initState() {
    super.initState();
    context.read<FilterCubit>().loadTopProviders(widget.mainServiceId);
  }

  Future<bool> _getUserLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        setState(() => _isLoadingLocation = false);
        return false;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _userLat = position.latitude;
        _userLng = position.longitude;
        _isLoadingLocation = false;
      });
      return true;
    } catch (e) {
      debugPrint("Location error: $e");
      setState(() => _isLoadingLocation = false);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        withScaffold: false,
        padding: EdgeInsets.only(top: 65.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Filter Icon ──
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Builder(
                    builder: (context) => Container(
                      width: 35.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: IconButton(
                        onPressed: () => _openFilter(context),
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                          size: 23,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Gap(12.h),

            // ── Sort By (يظهر فقط بعد الفلترة) ──
            if (isFiltered)
              Builder(builder: (context) => _buildSortBy(context)),

            // ── Label ──
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Text(
                isFiltered ? 'Results' : 'Top 5 providers',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
            ),

            // ── BlocBuilder ──
            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, state) {
                // ── Loading ──
                if (state.status == FilterStatus.loading ||
                    _isLoadingLocation) {
                  return SizedBox(
                    height: 300.h,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF6C5CE7),
                      ),
                    ),
                  );
                }

                // ── Error ──
                if (state.status == FilterStatus.error) {
                  return SizedBox(
                    height: 200.h,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.errorMessage ?? 'An error occurred',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => context
                                .read<FilterCubit>()
                                .loadTopProviders(widget.mainServiceId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF6C5CE7),
                            ),
                            child: const Text(
                              'Retry',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final List<ProviderFilterModel> currentProviders = isFiltered
                    ? state.filteredProviders
                    : state.topProviders;

                if (currentProviders.isEmpty) {
                  return SizedBox(
                    height: 200.h,
                    child: const Center(
                      child: Text("No providers found matching these criteria"),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: currentProviders.length,
                  separatorBuilder: (context, _) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final item = currentProviders[index];

                    final entity = ProviderEntity(
                      id: item.providerUserId ?? 0,
                      name: item.name ?? 'No Name',
                      photo: item.photo,
                      subServiceName: item.workType ?? '',
                      locationName: item.locationName ?? 'Unknown',
                      workType: item.workType ?? 'both',
                      minPrice: item.minPrice?.toDouble() ?? 0.0,
                      maxPrice: item.maxPrice?.toDouble() ?? 0.0,
                      avgRating: item.avgRating?.toDouble() ?? 0.0,
                      isAvailable: item.isAvailable ?? false,
                    );

                    return ProviderCardWidget(
                      provider: entity,
                      onTap: () async {
                        await GoRouter.of(
                          context,
                        ).push(AppRouter.kProfileLabourer, extra: entity.id);

                        if (context.mounted) {
                          if (isFiltered) {
                            context.read<FilterCubit>().fetchFilteredProviders(
                              FilterRequestModel(
                                mainServiceId: widget.mainServiceId,
                                subServiceId: currentSubServiceId,
                                minPrice: currentMinPrice,
                                maxPrice: currentMaxPrice,
                                rating: currentRating,
                                isAvailableNow: currentAvailability,
                                workType: currentWorkType,
                                sortBy: sortBy,
                              ),
                            );
                          } else {
                            context.read<FilterCubit>().loadTopProviders(
                              widget.mainServiceId,
                            );
                          }
                        }
                      },
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

  // ── Sort By Widget ──
  Widget _buildSortBy(BuildContext context) {
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
                onTap: () async {
                  if (isSelected) return;

                  if (value == 'location') {
                    final gotLocation = await _getUserLocation();
                    if (!gotLocation || _userLat == null || _userLng == null) {
                      if (mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Could not get your location. Please enable GPS.",
                            ),
                            backgroundColor: Colors.orange,
                          ),
                        );
                      }
                      return;
                    }

                    setState(() => sortBy = value);
                    if (mounted) {
                      context
                          .read<FilterCubit>()
                          .fetchFilteredProvidersAndSortByLocation(
                            request: FilterRequestModel(
                              mainServiceId: widget.mainServiceId,
                              subServiceId: currentSubServiceId,
                              minPrice: currentMinPrice,
                              maxPrice: currentMaxPrice,
                              rating: currentRating,
                              isAvailableNow: currentAvailability,
                              workType: currentWorkType,
                            ),
                            userLat: _userLat!,
                            userLng: _userLng!,
                          );
                    }
                    return;
                  }

                  setState(() => sortBy = value);
                  if (mounted) {
                    context.read<FilterCubit>().fetchFilteredProviders(
                      FilterRequestModel(
                        mainServiceId: widget.mainServiceId,
                        subServiceId: currentSubServiceId,
                        minPrice: currentMinPrice,
                        maxPrice: currentMaxPrice,
                        rating: currentRating,
                        isAvailableNow: currentAvailability,
                        workType: currentWorkType,
                        sortBy: value,
                      ),
                    );
                  }
                },
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
          Divider(color: Colors.grey.shade200, height: 2),
        ],
      ),
    );
  }

  // ── فتح الفلتر ──
  void _openFilter(BuildContext parentContext) {
    parentContext.read<FilterCubit>().loadSubServices(widget.mainServiceId);

    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: parentContext.read<FilterCubit>(),
        child: FilterBottomSheet(
          initialSubServiceId: currentSubServiceId,
          initialMinPrice: currentMinPrice,
          initialMaxPrice: currentMaxPrice,
          initialRating: currentRating != null
              ? int.tryParse(currentRating!)
              : null,
          initialAvailability: currentAvailability == true
              ? "Available Now"
              : "Any",
          initialWorkType: currentWorkType,
          onApply:
              ({
                int? subServiceId,
                minPrice,
                maxPrice,
                rating,
                availability,
                workType,
              }) {
                setState(() {
                  isFiltered = true;
                  sortBy = null;
                  currentSubServiceId = subServiceId;
                  currentMinPrice = minPrice;
                  currentMaxPrice = maxPrice;
                  currentRating = rating?.toString();
                  currentAvailability = availability == "Available Now";
                  currentWorkType = workType;
                });

                parentContext.read<FilterCubit>().fetchFilteredProviders(
                  FilterRequestModel(
                    mainServiceId: widget.mainServiceId,
                    subServiceId: subServiceId,
                    minPrice: minPrice,
                    maxPrice: maxPrice,
                    rating: rating?.toString(),
                    isAvailableNow: currentAvailability,
                    workType: workType,
                  ),
                );
              },
        ),
      ),
    );
  }
}
