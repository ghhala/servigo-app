import 'dart:io';

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
  Future<void> updateProviderProfile(Map<String, dynamic> body) async {
  try {
    await _remoteDataSource.updateProviderProfile(body);
  } catch (e) {
    rethrow;
  }
}
Future<void> updateCertificates({
  required List<File> newFiles,
  required List<int> removeIds,
}) async {
  try {
    await _remoteDataSource.updateCertificates(
      newFiles: newFiles,
      removeIds: removeIds,
    );
  } catch (e) {
    rethrow;
  }
}

Future<void> updateGallery({
  required List<Map<String, dynamic>> newItems,
  required List<int> removeIds,
}) async {
  try {
    await _remoteDataSource.updateGallery(
      newItems: newItems,
      removeIds: removeIds,
    );
  } catch (e) {
    rethrow;
  }
}

  // ✅ الإبلاغ عن مراجعة
  Future<void> reportRating({
    required int ratingId,
    required String reason,
  }) async {
    try {
      await _remoteDataSource.reportRating(ratingId: ratingId, reason: reason);
    } catch (e) {
      rethrow;
    }
  }

  // ✅ حذف مراجعة
  Future<void> deleteRating(int ratingId) async {
    try {
      await _remoteDataSource.deleteRating(ratingId);
    } catch (e) {
      rethrow;
    }
  }

  
  Future<Set<int>> getMyRatingIds() async {
    try {
      final response = await _remoteDataSource.getMyRatings();
      final bool success = response['success'] ?? false;
      if (!success) return {};
      final List data = response['data'] ?? [];
      return data
          .map<int?>((e) => e['id'] as int?)
          .whereType<int>()
          .toSet();
    } catch (e) {
      return {};
    }
  }
}