import 'package:dio/dio.dart';
import 'package:servi_go_app/features/user_profile/data/models/edit_profile_response_model.dart';

import '../../../../core/network/api_service.dart';
import '../models/user_profile_model.dart';

class UserProfileRemoteDataSource {
  final ApiService _apiService;

  UserProfileRemoteDataSource(this._apiService);

  Future<UserProfileModel> getUserProfile() async {
    
    final response = await _apiService.get('customer/profile');
    
    
    return UserProfileModel.fromJson(response);
  }
  Future<EditProfileResponseModel> updateProfile({
    required String name,
    required String phone,
  }) async {
    
    final formData = FormData.fromMap({
      '_method': 'PUT', 
      'name': name,
      'phone': phone,
    });

    
    final response = await _apiService.post(
      'customer/profile', 
      formData, 
    );

    return EditProfileResponseModel.fromJson(response);
  }
}