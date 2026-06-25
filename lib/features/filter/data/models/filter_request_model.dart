class FilterRequestModel {
  final int mainServiceId;        // ✅ جديد - إلزامي
  final int? subServiceId;
  final num? minPrice;
  final num? maxPrice;
  final String? rating;
  final bool? isAvailableNow;
  final String? workType;
  final String? sortBy;
  final double? userLat;
  final double? userLng;

  FilterRequestModel({
    required this.mainServiceId,  // ✅ جديد
    this.subServiceId,
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.isAvailableNow,
    this.workType,
    this.sortBy,
    this.userLat,
    this.userLng,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'main_service_id': mainServiceId,  // ✅ جديد
    };
    if (subServiceId != null) data['sub_service_id'] = subServiceId;
    if (minPrice != null) data['min_price'] = minPrice;
    if (maxPrice != null) data['max_price'] = maxPrice;
    if (rating != null) data['rating'] = rating;
    // ✅ صححنا الاسم ليطابق التوثيق
    if (isAvailableNow != null) {
      data['availability'] = isAvailableNow! ? 'available_now' : 'any';
    }
    if (workType != null) data['work_type'] = workType;
    if (sortBy != null) data['sort_by'] = sortBy;
    // ✅ صححنا الأسماء لتطابق latitude/longitude
    if (userLat != null) data['latitude'] = userLat;
    if (userLng != null) data['longitude'] = userLng;
    return data;
  }
}