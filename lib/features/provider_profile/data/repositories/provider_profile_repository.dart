

import 'package:servi_go_app/features/provider_profile/data/data_sources/provider_profile_remote_data_source.dart';
import 'package:servi_go_app/features/provider_profile/data/models/provider_profile_model.dart';

class ProviderProfileRepository {
  final ProviderProfileRemoteDataSource _remoteDataSource;
  ProviderProfileRepository(this._remoteDataSource);

  Future<ProviderProfileModel> getProviderProfile({int? providerId}) async {
    try {
      final response =
          await _remoteDataSource.getProviderProfile(providerId: providerId);
      return ProviderProfileModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> toggleFavourite(int providerId) async {
    try {
      final response = await _remoteDataSource.toggleFavourite(providerId);
      // ✅ نتوقع رد فيه is_favourite بعد التبديل
      return response['data']?['is_favourite'] ??
          response['is_favourite'] ??
          false;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendComplaint({
    required int providerId,
    required String message,
  }) async {
    try {
      await _remoteDataSource.sendComplaint(
        providerId: providerId,
        message: message,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> rateProvider({
    required int providerId,
    required int rating,
    required String review,
  }) async {
    try {
      await _remoteDataSource.rateProvider(
        providerId: providerId,
        rating: rating,
        review: review,
      );
    } catch (e) {
      rethrow;
    }
  }
}