

// import 'package:servi_go_app/core/network/api_service.dart';

// class ProviderProfileRemoteDataSource {
//   final ApiService _apiService;

//   ProviderProfileRemoteDataSource(this._apiService);

//   // ✅ هنا أضف الـ prints
//   Future<dynamic> getProviderProfile() async {
//     print("📡 إرسال طلب لـ provider/myprofile...");
//     final response = await _apiService.get('provider/myprofile');
//     print("📦 الرد: $response");
//     return response;
//   }
// }

import 'package:servi_go_app/core/network/api_service.dart';

class ProviderProfileRemoteDataSource {
  final ApiService _apiService;

  ProviderProfileRemoteDataSource(this._apiService);

  // 🚀 التعديل هنا: إضافة المعامل الاختياري {int? providerId}
  Future<dynamic> getProviderProfile({int? providerId}) async {
    String endpoint;

    if (providerId != null) {
      // 💡 إذا تم تمرير معرف، نتوجه إلى مسار عرض بيانات هذا الحساب المحدد
      endpoint = 'api/provider/$providerId'; 
    } else {
      // 💡 إذا كان null، نتوجه إلى مسار البروفايل الشخصي للمستخدم الحالي
      endpoint = 'provider/myprofile';
    }

    print("📡 إرسال طلب لـ $endpoint...");
    final response = await _apiService.get(endpoint);
    print("📦 الرد: $response");
    return response;
  }
}