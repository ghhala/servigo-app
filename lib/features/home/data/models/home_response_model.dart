class HomeResponseModel {
  final bool? success;
  final String? message;
  final HomeData? data;

  HomeResponseModel({this.success, this.message, this.data});

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? HomeData.fromJson(json['data']) : null,
    );
  }
}

class HomeData {
  final List<MainService>? mainServices;
  final List<FavoriteProvider>? favorites; 
  final List<HomeAd>? ads;                 

  HomeData({this.mainServices, this.favorites, this.ads});

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      mainServices: json['main_services'] != null
          ? List<MainService>.from(
              json['main_services'].map((x) => MainService.fromJson(x)))
          : [],
      favorites: json['favorites'] != null
          ? List<FavoriteProvider>.from(
              json['favorites'].map((x) => FavoriteProvider.fromJson(x)))
          : [],
      ads: json['ads'] != null
          ? List<HomeAd>.from(json['ads'].map((x) => HomeAd.fromJson(x)))
          : [],
    );
  }
}

class MainService {
  final int? id;
  final String? nameAr;
  final String? nameEn;
  final String? photo;

  MainService({this.id, this.nameAr, this.nameEn, this.photo});

  factory MainService.fromJson(Map<String, dynamic> json) {
    return MainService(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
      photo: json['photo'],
    );
  }
}


class FavoriteProvider {
  final int? id;
  final String? name;
  final String? photo;
  final MainService? mainService;
  final SubService? subService;

  FavoriteProvider({this.id, this.name, this.photo, this.mainService, this.subService});

  factory FavoriteProvider.fromJson(Map<String, dynamic> json) {
    return FavoriteProvider(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      mainService: json['main_service'] != null ? MainService.fromJson(json['main_service']) : null,
      subService: json['sub_service'] != null ? SubService.fromJson(json['sub_service']) : null,
    );
  }
}

class SubService {
  final int? id;
  final String? nameAr;
  final String? nameEn;

  SubService({this.id, this.nameAr, this.nameEn});

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'],
      nameAr: json['name_ar'],
      nameEn: json['name_en'],
    );
  }
}


class HomeAd {
  final int? id;
  final String? titleAr;
  final String? titleEn;
  final String? contentAr;
  final String? contentEn;
  final String? photo;

  HomeAd({this.id, this.titleAr, this.titleEn, this.contentAr, this.contentEn, this.photo});

  factory HomeAd.fromJson(Map<String, dynamic> json) {
    return HomeAd(
      id: json['id'],
      titleAr: json['title_ar'],
      titleEn: json['title_en'],
      contentAr: json['content_ar'],
      contentEn: json['content_en'],
      photo: json['photo'],
    );
  }
}