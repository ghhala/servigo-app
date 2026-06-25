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
}

class ProfileData {
  final UserInfo? user;
  final ProviderInfo? provider;
  final num? avgRating;
  final List<dynamic>? ratings;
  final List<CertificateModel>? certificates;
  final List<PortfolioModel>? portfolio;

  ProfileData({
    this.user,
    this.provider,
    this.avgRating,
    this.ratings,
    this.certificates,
    this.portfolio,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      user: json['user'] != null ? UserInfo.fromJson(json['user']) : null,
      provider: json['provider'] != null ? ProviderInfo.fromJson(json['provider']) : null,
      avgRating: json['avg_rating'],
      ratings: json['ratings'] != null ? List<dynamic>.from(json['ratings']) : [],
      certificates: json['certificates'] != null
          ? (json['certificates'] as List).map((i) => CertificateModel.fromJson(i)).toList()
          : [],
      portfolio: json['portfolio'] != null
          ? (json['portfolio'] as List).map((i) => PortfolioModel.fromJson(i)).toList()
          : [],
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
      latitude: json['latitude'],
      longitude: json['longitude'],
      locationDescription: json['location_description'],
      workType: json['work_type'],
      mainServiceId: json['main_service_id'],
      mainServiceName: json['main_service_name'],
      subServiceId: json['sub_service_id'],
      subServiceName: json['sub_service_name'],
      currency: json['currency'],
      minPrice: json['min_price'],
      maxPrice: json['max_price'],
      workStartTime: json['work_start_time'],
      workEndTime: json['work_end_time'],
      overnight: json['overnight'],
      aboutMe: json['about_me'],
      offDays: json['off_days'] != null ? List<String>.from(json['off_days']) : [],
      isAvailable: json['is_available'],
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