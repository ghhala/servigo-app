
import 'package:servi_go_app/core/network/api_service.dart';

class ProviderProfileRemoteDataSource {
  final ApiService _apiService;
  ProviderProfileRemoteDataSource(this._apiService);

  Future<dynamic> getProviderProfile({int? providerId}) async {
    String endpoint;
    if (providerId != null) {
      endpoint = 'profile/$providerId';
    } else {
      endpoint = 'provider/myprofile';
    }
    print("📡 إرسال طلب لـ $endpoint...");
    final response = await _apiService.get(endpoint);
    print("📦 الرد: $response");
    return response;
  }

  // ✅ إضافة/إزالة من المفضلة
  Future<dynamic> toggleFavourite(int providerId) async {
    final response =
        await _apiService.post('customer/favourites/$providerId', {});
    return response;
  }

  // ✅ إرسال شكوى ضد مقدم الخدمة
  Future<dynamic> sendComplaint({
    required int providerId,
    required String message,
  }) async {
    final response = await _apiService.post(
      'provider/$providerId/complaints',
      {'message': message},
    );
    return response;
  }

  Future<dynamic> rateProvider({
    required int providerId,
    required int rating,
    required String review,
  }) async {
    final response = await _apiService.post(
      'provider/$providerId/rate',
      {'rating': rating, 'review': review},
    );
    return response;
  }
}