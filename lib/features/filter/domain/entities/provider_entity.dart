
class ProviderEntity {
  final int id;
  final String name;
  final String? photo;
  final String subServiceName;
  final String locationName;
  final String workType;
  final double minPrice;
  final double maxPrice;
  final double avgRating;
  final bool isAvailable;

  const ProviderEntity({
    required this.id,
    required this.name,
    this.photo,
    required this.subServiceName,
    required this.locationName,
    required this.workType,
    required this.minPrice,
    required this.maxPrice,
    required this.avgRating,
    required this.isAvailable,
  });
}