class HomeResponseModel {
  final bool? success;
  final String? message;
  final HomeData? data;

  HomeResponseModel({
    this.success,
    this.message,
    this.data,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeResponseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] != null ? HomeData.fromJson(json['data']) : null,
    );
  }
}

class HomeData {
  final List<MainService> mainServices;
  final List<FavoriteProvider> favorites;
  final List<HomeAd> ads;

  HomeData({
    required this.mainServices,
    required this.favorites,
    required this.ads,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    // جلب القوائم كـ List قابلة لـ Null بشكل آمن وتجنب الـ Type Cast Error
    final mainServicesJson = json['main_services'] as List?;
    final favoritesJson = json['favorites'] as List?;
    final adsJson = json['ads'] as List?;

    return HomeData(
      mainServices: mainServicesJson != null
          ? mainServicesJson
              .map((x) => MainService.fromJson(x as Map<String, dynamic>))
              .toList()
          : [],
      favorites: favoritesJson != null
          ? favoritesJson
              .map((x) => FavoriteProvider.fromJson(x as Map<String, dynamic>))
              .toList()
          : [],
      ads: adsJson != null
          ? adsJson
              .map((x) => HomeAd.fromJson(x as Map<String, dynamic>))
              .toList()
          : [],
    );
  }
}

class MainService {
  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? photo;

  MainService({
    this.id,
    this.nameAr,
    this.nameEn,
    this.photo,
  });

  factory MainService.fromJson(Map<String, dynamic> json) {
    return MainService(
      id: json['id'] as int?,
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
      photo: json['photo'] as String?,
    );
  }
}

class SubService {
  final int? id;
  final String? nameAr;
  final String? nameEn;

  SubService({
    this.id,
    this.nameAr,
    this.nameEn,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'] as int?,
      nameAr: json['name_ar'] as String?,
      nameEn: json['name_en'] as String?,
    );
  }
}

class FavoriteProvider {
  final int? providerUserId;
  final String? name;
  final String? photo;
  final MainService? mainService;
  final SubService? subService;

  FavoriteProvider({
    this.providerUserId,
    this.name,
    this.photo,
    this.mainService,
    this.subService,
  });

  factory FavoriteProvider.fromJson(Map<String, dynamic> json) {
    return FavoriteProvider(
      providerUserId: json['provider_user_id'] as int?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      // فحص أمان إضافي للكائنات المتداخلة داخل المفضلة
      mainService: json['main_service'] != null
          ? MainService.fromJson(json['main_service'] as Map<String, dynamic>)
          : null,
      subService: json['sub_service'] != null
          ? SubService.fromJson(json['sub_service'] as Map<String, dynamic>)
          : null,
    );
  }
}

class HomeAd {
  final int? adId;
  final int? providerUserId;
  final String? providerName;
  final String? providerPhoto;
  final String? adImage;
  final String? description;

  HomeAd({
    this.adId,
    this.providerUserId,
    this.providerName,
    this.providerPhoto,
    this.adImage,
    this.description,
  });

  factory HomeAd.fromJson(Map<String, dynamic> json) {
    return HomeAd(
      adId: json['ad_id'] as int?,
      providerUserId: json['provider_user_id'] as int?,
      providerName: json['provider_name'] as String?,
      providerPhoto: json['provider_photo'] as String?,
      adImage: json['ad_image'] as String?,
      description: json['description'] as String?,
    );
  }
}