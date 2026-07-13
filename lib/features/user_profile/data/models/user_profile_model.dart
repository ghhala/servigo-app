class UserProfileModel {
  final bool? success;
  final String? message;
  final UserProfileData? data;

  UserProfileModel({this.success, this.message, this.data});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? UserProfileData.fromJson(json['data']) : null,
    );
  }
}

class UserProfileData {
  final int? id;
  final String? name;
  final String? phone;
  final String? photo;
  final String? email;

  UserProfileData({this.id, this.name, this.phone, this.photo, this.email});

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      photo: json['photo'],
    );
  }

  UserProfileData copyWith({
    int? id,
    String? name,
    String? phone,
    String? photo,
    String? email,
  }) {
    return UserProfileData(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      email: email ?? this.email,
    );
  }
}
