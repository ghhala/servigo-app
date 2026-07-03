class ProviderProfileModel {
  final bool? success;
  final String? message;
  final ProfileData? data;

  ProviderProfileModel({this.success, this.message, this.data});

  factory ProviderProfileModel.fromJson(Map<String, dynamic> json) {
    return ProviderProfileModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? ProfileData.fromJson(json['data']) : null,
    );
  }

  ProviderProfileModel copyWith({ProfileData? data}) {
    return ProviderProfileModel(
      success: success,
      message: message,
      data: data ?? this.data,
    );
  }
}

class ProfileData {
  final UserInfo? user;
  final ProviderInfo? provider;
  final num? avgRating;
  final List<RatingModel>? ratings;
  final List<CertificateModel>? certificates;
  final List<PortfolioModel>? portfolio;
  final bool? isFavourite;

  ProfileData({
    this.user,
    this.provider,
    this.avgRating,
    this.ratings,
    this.certificates,
    this.portfolio,
    this.isFavourite,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    final bool isMyProfile =
        json.containsKey('user') && json.containsKey('provider');

    return ProfileData(
      user: isMyProfile
          ? UserInfo.fromJson(json['user'])
          : UserInfo.fromJson(json),

      provider: isMyProfile
          ? ProviderInfo.fromJson(json['provider'])
          : ProviderInfo.fromJson(json),

      avgRating: json['avg_rating'],

      ratings: json['ratings'] != null
          ? (json['ratings'] as List)
              .map((i) => RatingModel.fromJson(i))
              .toList()
          : [],

      certificates: json['certificates'] != null
          ? (json['certificates'] as List)
              .map((i) => CertificateModel.fromJson(i))
              .toList()
          : [],

      portfolio: json['portfolio'] != null
          ? (json['portfolio'] as List)
              .map((i) => PortfolioModel.fromJson(i))
              .toList()
          : [],

      isFavourite: json['is_favourite'] is bool
          ? json['is_favourite']
          : (json['is_favourite'] == 1 || json['is_favourite'] == '1'),
    );
  }

  ProfileData copyWith({bool? isFavourite}) {
    return ProfileData(
      user: user,
      provider: provider,
      avgRating: avgRating,
      ratings: ratings,
      certificates: certificates,
      portfolio: portfolio,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}

class UserInfo {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? photo;

  UserInfo({this.id, this.name, this.phone, this.email, this.photo});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      photo: json['photo'],
    );
  }
}

class ProviderInfo {
  final int? id;
  final String? locationName;
  final String? latitude;
  final String? longitude;
  final String? locationDescription;
  final String? workType;
  final int? mainServiceId;
  final String? mainServiceName;
  final int? subServiceId;
  final String? subServiceName;
  final String? currency;
  final String? minPrice;
  final String? maxPrice;
  final String? workStartTime;
  final String? workEndTime;
  final bool? overnight;
  final String? aboutMe;
  final List<String>? offDays;
  final int? isAvailable;
  final String? status;
  final bool? profileCompleted;

  ProviderInfo({
    this.id,
    this.locationName,
    this.latitude,
    this.longitude,
    this.locationDescription,
    this.workType,
    this.mainServiceId,
    this.mainServiceName,
    this.subServiceId,
    this.subServiceName,
    this.currency,
    this.minPrice,
    this.maxPrice,
    this.workStartTime,
    this.workEndTime,
    this.overnight,
    this.aboutMe,
    this.offDays,
    this.isAvailable,
    this.status,
    this.profileCompleted,
  });

  factory ProviderInfo.fromJson(Map<String, dynamic> json) {
    return ProviderInfo(
      id: json['id'],

      locationName: json['location_name'],
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      locationDescription: json['location_description'],

      workType: json['work_type'],

      mainServiceId:
          json['main_service_id'] ?? json['main_service']?['id'],

      mainServiceName:
          json['main_service_name'] ??
          json['main_service']?['name_en'] ??
          json['main_service']?['name_ar'],

      subServiceId:
          json['sub_service_id'] ?? json['sub_service']?['id'],

      subServiceName:
          json['sub_service_name'] ??
          json['sub_service']?['name_en'] ??
          json['sub_service']?['name_ar'],

      currency: json['currency'],

      minPrice: json['min_price']?.toString(),
      maxPrice: json['max_price']?.toString(),

      workStartTime: json['work_start_time'],
      workEndTime: json['work_end_time'],

      overnight: json['overnight'],

      aboutMe: json['about_me'],

      offDays: json['off_days'] != null
          ? List<String>.from(json['off_days'])
          : [],

      isAvailable: json['is_available'] is bool
          ? ((json['is_available'] as bool) ? 1 : 0)
          : json['is_available'],

      status: json['status'],

      profileCompleted: json['profile_completed'],
    );
  }
}

class CertificateModel {
  final int? id;
  final String? filePath;

  CertificateModel({this.id, this.filePath});

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id'],
      filePath: json['file_path'],
    );
  }
}

class PortfolioModel {
  final int? id;
  final String? filePath;
  final String? fileType;
  final String? description;

  PortfolioModel({this.id, this.filePath, this.fileType, this.description});

  factory PortfolioModel.fromJson(Map<String, dynamic> json) {
    return PortfolioModel(
      id: json['id'],
      filePath: json['file_path'],
      fileType: json['file_type'],
      description: json['description'],
    );
  }
}

// ✅ محدَّث ليطابق الـ JSON الفعلي: customer_name / customer_photo بدل user_name
class RatingModel {
  final int? id;
  final String? customerName;
  final String? customerPhoto;
  final int? rating;
  final String? review;
  final String? createdAt;

  RatingModel({
    this.id,
    this.customerName,
    this.customerPhoto,
    this.rating,
    this.review,
    this.createdAt,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      id: json['id'],
      customerName: json['customer_name'],
      customerPhoto: json['customer_photo'],
      rating: json['rating'],
      review: json['review'],
      createdAt: json['created_at'],
    );
  }
}