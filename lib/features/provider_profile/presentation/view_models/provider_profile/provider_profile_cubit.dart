import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/provider_profile_repository.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_state.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  final ProviderProfileRepository _repository;
  ProviderProfileCubit(this._repository) : super(ProviderProfileInitial());

  Future<void> fetchProviderProfile({int? providerId}) async {
    emit(ProviderProfileLoading());
    try {
      final profileModel = await _repository.getProviderProfile(
        providerId: providerId,
      );

      // ✅ بنجيب مراجعاتي أنا بس لما نشوف بروفايل مزود تاني (مو بروفايلي)
      Set<int> myRatingIds = {};
      if (providerId != null) {
        myRatingIds = await _repository.getMyRatingIds();
      }

      emit(ProviderProfileSuccess(profileModel, myRatingIds: myRatingIds));
    } catch (e) {
      emit(ProviderProfileFailure(e.toString()));
    }
  }

  Future<void> toggleFavourite({required int providerId}) async {
    final currentState = state;
    if (currentState is! ProviderProfileSuccess) return;

    final currentData = currentState.profileModel.data;
    if (currentData == null) return;

    final bool previousValue = currentData.isFavourite ?? false;

    emit(
      ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(isFavourite: !previousValue),
        ),
        myRatingIds: currentState.myRatingIds,
      ),
    );

    try {
      final serverValue = await _repository.toggleFavourite(providerId);
      emit(
        ProviderProfileSuccess(
          currentState.profileModel.copyWith(
            data: currentData.copyWith(isFavourite: serverValue),
          ),
          myRatingIds: currentState.myRatingIds,
        ),
      );
    } catch (e) {
      emit(
        ProviderProfileSuccess(
          currentState.profileModel.copyWith(
            data: currentData.copyWith(isFavourite: previousValue),
          ),
          myRatingIds: currentState.myRatingIds,
        ),
      );
      rethrow;
    }
  }

  void updateAvailabilityLocally(bool value) {
    final currentState = state;
    if (currentState is! ProviderProfileSuccess) return;

    final currentData = currentState.profileModel.data;
    final currentProvider = currentData?.provider;
    if (currentData == null || currentProvider == null) return;

    emit(
      ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(
            provider: currentProvider.copyWith(isAvailable: value ? 1 : 0),
          ),
        ),
        myRatingIds: currentState.myRatingIds,
      ),
    );
  }

  void updateOvernightLocally(bool value) {
    final currentState = state;
    if (currentState is! ProviderProfileSuccess) return;

    final currentData = currentState.profileModel.data;
    final currentProvider = currentData?.provider;
    if (currentData == null || currentProvider == null) return;

    emit(
      ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(
            provider: currentProvider.copyWith(overnight: value),
          ),
        ),
        myRatingIds: currentState.myRatingIds,
      ),
    );
  }

  Future<void> sendComplaint({
    required int providerId,
    required String message,
  }) async {
    await _repository.sendComplaint(providerId: providerId, message: message);
  }

  Future<void> rateProvider({
    required int providerId,
    required int rating,
    required String review,
  }) async {
    await _repository.rateProvider(
      providerId: providerId,
      rating: rating,
      review: review,
    );
    await fetchProviderProfile(providerId: providerId);
  }
  Future<void> updateProviderProfile(Map<String, dynamic> body) async {
  await _repository.updateProviderProfile(body);
 
  await fetchProviderProfile();
}
Future<void> updateCertificates({
  required List<File> newFiles,
  required List<int> removeIds,
}) async {
  await _repository.updateCertificates(newFiles: newFiles, removeIds: removeIds);
}

Future<void> updateGallery({
  required List<Map<String, dynamic>> newItems,
  required List<int> removeIds,
}) async {
  await _repository.updateGallery(newItems: newItems, removeIds: removeIds);
}

  // ✅ الإبلاغ عن مراجعة — بس نداء API، بدون تعديل الـ state
  Future<void> reportRating({
    required int ratingId,
    required String reason,
  }) async {
    await _repository.reportRating(ratingId: ratingId, reason: reason);
  }

 
  Future<void> deleteRating(int ratingId) async {
    final currentState = state;
    if (currentState is! ProviderProfileSuccess) return;

    final currentData = currentState.profileModel.data;
    final currentRatings = currentData?.ratings;
    if (currentData == null || currentRatings == null) return;

    final updatedRatings =
        currentRatings.where((r) => r.id != ratingId).toList();

    final updatedMyRatingIds = Set<int>.from(currentState.myRatingIds)
      ..remove(ratingId);

    emit(
      ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(ratings: updatedRatings),
        ),
        myRatingIds: updatedMyRatingIds,
      ),
    );

    try {
      await _repository.deleteRating(ratingId);
    } catch (e) {
      emit(
        ProviderProfileSuccess(
          currentState.profileModel.copyWith(
            data: currentData.copyWith(ratings: currentRatings),
          ),
          myRatingIds: currentState.myRatingIds,
        ),
      );
      rethrow;
    }
  }
 
  Future<void> updateRating({
    required int ratingId,
    required int rating,
    required String review,
  }) async {
    final currentState = state;
    if (currentState is! ProviderProfileSuccess) return;

    final currentData = currentState.profileModel.data;
    final currentRatings = currentData?.ratings;
    if (currentData == null || currentRatings == null) return;

    final updatedRatings = currentRatings.map((r) {
      if (r.id == ratingId) {
        return r.copyWith(rating: rating, review: review);
      }
      return r;
    }).toList();

    emit(
      ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(ratings: updatedRatings),
        ),
        myRatingIds: currentState.myRatingIds,
      ),
    );

    try {
      await _repository.updateRating(
        ratingId: ratingId,
        rating: rating,
        review: review,
      );
    } catch (e) {
      emit(
        ProviderProfileSuccess(
          currentState.profileModel.copyWith(
            data: currentData.copyWith(ratings: currentRatings),
          ),
          myRatingIds: currentState.myRatingIds,
        ),
      );
      rethrow;
    }
  }
}