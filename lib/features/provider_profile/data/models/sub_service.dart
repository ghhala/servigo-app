class SubService {
  final int id;
  final String nameAr;
  final String nameEn;

  SubService({required this.id, required this.nameAr, required this.nameEn});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'] as int,
      nameAr: json['name_ar'] as String,
      nameEn: json['name_en'] as String,
    );
  }
}