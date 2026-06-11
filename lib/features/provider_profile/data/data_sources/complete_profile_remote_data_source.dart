import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/features/provider_profile/data/models/complete_profile_model.dart'; 
import 'package:servi_go_app/features/provider_profile/data/models/complete_profile_response.dart';

class CompleteProfileRemoteDataSource {
  final ApiService _apiService;

  CompleteProfileRemoteDataSource(this._apiService);

  Future<CompleteProfileResponse> completeProfile(CompleteProfileModel params) async {
   
    final formData = await params.toFormData();
    
   
    final response = await _apiService.postFormData(
      'provider/complete-profile', 
      formData,
    );
    
   
    return CompleteProfileResponse.fromJson(response);
  }
}