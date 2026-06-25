// import 'package:servi_go_app/core/network/api_service.dart';

// class ProviderProfileRemoteDataSource {
//   final ApiService _apiService;

//   ProviderProfileRemoteDataSource(this._apiService);

 
//   Future<dynamic> getProviderProfile() async {
   
//     final response = await _apiService.get('provider/myprofile');
//     return response;
//   }
// }

import 'package:servi_go_app/core/network/api_service.dart';

class ProviderProfileRemoteDataSource {
  final ApiService _apiService;

  ProviderProfileRemoteDataSource(this._apiService);

  // ✅ هنا أضف الـ prints
  Future<dynamic> getProviderProfile() async {
    print("📡 إرسال طلب لـ provider/myprofile...");
    final response = await _apiService.get('provider/myprofile');
    print("📦 الرد: $response");
    return response;
  }
}