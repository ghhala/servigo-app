import '../../../../core/network/api_service.dart'; 
import '../models/home_response_model.dart';

class HomeRemoteDataSource {
  final ApiService _apiService;

  HomeRemoteDataSource(this._apiService);

  Future<HomeResponseModel> getHomeData() async {
    try {
     
      final response = await _apiService.get('home');
      
      return HomeResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}