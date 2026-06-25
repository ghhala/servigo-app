class ProviderFilterModel {
  final int? providerUserId;
  final String? name;
  final String? photo;
  final num? avgRating;
  final num? minPrice;
  final num? maxPrice;
  final String? currency;
  final String? workType;
  final String? locationName;
  final bool? isAvailable;

  ProviderFilterModel({
    this.providerUserId,
    this.name,
    this.photo,
    this.avgRating,
    this.minPrice,
    this.maxPrice,
    this.currency,
    this.workType,
    this.locationName,
    this.isAvailable,
  });

 
  factory ProviderFilterModel.fromJson(Map<String, dynamic> json) {
    return ProviderFilterModel(
      providerUserId: json['provider_user_id'] as int?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      avgRating: json['avg_rating'] as num?,
      minPrice: json['min_price'] as num?,
      maxPrice: json['max_price'] as num?,
      currency: json['currency'] as String?,
      workType: json['work_type'] as String?,
      locationName: json['location_name'] as String?,
      isAvailable: json['is_available'] as bool?,
    );
  }
}