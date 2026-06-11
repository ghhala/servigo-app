import 'package:servi_go_app/core/network/api_service.dart';
import '../models/sub_services_response.dart';

class SubServicesRemoteDataSource {
  final ApiService _apiService;

  SubServicesRemoteDataSource(this._apiService);

  Future<SubServicesResponse> getSubServices(int mainServiceId) async {
  
    final response = await _apiService.get('search/sub-services/$mainServiceId');
    return SubServicesResponse.fromJson(response);
  }
}