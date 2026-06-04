class UserSignUpResponseModel {
  final bool? success;
  final String? message;
  final SignUpData? data;

  UserSignUpResponseModel({this.success, this.message, this.data});

  
  factory UserSignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return UserSignUpResponseModel(
      success: json['success'],
      message: json['message'],
      data: json['data'] != null ? SignUpData.fromJson(json['data']) : null,
    );
  }
}

class SignUpData {
  final String? email;

  SignUpData({this.email});

  factory SignUpData.fromJson(Map<String, dynamic> json) {
    return SignUpData(
      email: json['email'],
    );
  }
}