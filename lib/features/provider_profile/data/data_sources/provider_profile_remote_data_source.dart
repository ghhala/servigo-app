import 'package:servi_go_app/core/network/api_service.dart';
import 'dart:io';
import 'package:dio/dio.dart';

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

  Future<dynamic> toggleFavourite(int providerId) async {
    final response =
        await _apiService.post('customer/favourites/$providerId', {});
    return response;
  }

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
  Future<dynamic> updateProviderProfile(Map<String, dynamic> body) async {
  final response = await _apiService.put('provider/profile', body);
  return response;
}
 Future<dynamic> updateCertificates({
    required List<File> newFiles,
    required List<int> removeIds,
  }) async {
    final formDataMap = <String, dynamic>{};

    for (int i = 0; i < newFiles.length; i++) {
      formDataMap['certificates[$i]'] = await MultipartFile.fromFile(
        newFiles[i].path,
        filename: newFiles[i].path.split('/').last,
      );
    }

    for (int i = 0; i < removeIds.length; i++) {
      formDataMap['remove_certificate_ids[$i]'] = removeIds[i].toString();
    }

    final formData = FormData.fromMap(formDataMap);
    final response = await _apiService.postFormData(
      'provider/profile/certificates',
      formData,
    );
    return response;
  }

  
  Future<dynamic> updateGallery({
    required List<Map<String, dynamic>> newItems, // [{file: File, description: String}]
    required List<int> removeIds,
  }) async {
    final formDataMap = <String, dynamic>{};

    for (int i = 0; i < newItems.length; i++) {
      final File file = newItems[i]['file'];
      final String description = newItems[i]['description'] ?? '';

      formDataMap['gallery[$i][file]'] = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      );
      formDataMap['gallery[$i][description]'] = description;
    }

    for (int i = 0; i < removeIds.length; i++) {
      formDataMap['remove_gallery_ids[$i]'] = removeIds[i].toString();
    }

    final formData = FormData.fromMap(formDataMap);
    final response = await _apiService.postFormData(
      'provider/gallery',
      formData,
    );
    return response;
  }

 
  Future<dynamic> reportRating({
    required int ratingId,
    required String reason,
  }) async {
    final response = await _apiService.post(
      'ratings/$ratingId/report',
      {'reason': reason},
    );
    return response;
  }

 
  Future<dynamic> deleteRating(int ratingId) async {
    final response = await _apiService.delete('ratings/$ratingId');
    return response;
  }

 
  Future<dynamic> getMyRatings() async {
    final response = await _apiService.get('ratings/user/my_ratings');
    return response;
  }
  Future<dynamic> updateRating({
    required int ratingId,
    required int rating,
    required String review,
  }) async {
    final response = await _apiService.put(
      'ratings/$ratingId',
      {'rating': rating, 'review': review},
    );
    return response;
  }
}