import 'package:servi_go_app/features/user_profile/data/models/edit_profile_response_model.dart';

import '../data_sources/user_profile_remote_data_source.dart';
import '../models/user_profile_model.dart';

class UserProfileRepository {
  final UserProfileRemoteDataSource _remoteDataSource;

  UserProfileRepository(this._remoteDataSource);

  Future<UserProfileModel> getUserProfile() async {
    try {
      return await _remoteDataSource.getUserProfile();
    } catch (e) {
      throw Exception("Failed to load profile data: $e");
    }
  }

 
  Future<EditProfileResponseModel> updateProfile({
    required String name,
    required String phone,
  }) async {
    try {
      return await _remoteDataSource.updateProfile(name: name, phone: phone);
    } catch (e) {
     
      throw Exception("Failed to update profile: $e");
    }
  }
}