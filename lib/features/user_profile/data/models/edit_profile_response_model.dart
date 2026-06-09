import 'package:servi_go_app/features/user_profile/data/models/user_profile_model.dart';

class EditProfileResponseModel {
  final bool? success;
  final String? message;
  final UserProfileData? data;

  EditProfileResponseModel({this.success, this.message, this.data});

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return EditProfileResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? UserProfileData.fromJson(json['data']) : null,
    );
  }
}