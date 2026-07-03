import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/provider_profile/data/repositories/provider_profile_repository.dart';
import 'package:servi_go_app/features/provider_profile/presentation/view_models/provider_profile/provider_profile_state.dart';

class ProviderProfileCubit extends Cubit<ProviderProfileState> {
  final ProviderProfileRepository _repository;
  ProviderProfileCubit(this._repository) : super(ProviderProfileInitial());

  Future<void> fetchProviderProfile({int? providerId}) async {
    emit(ProviderProfileLoading());
    try {
      final profileModel = await _repository.getProviderProfile(providerId: providerId);
      emit(ProviderProfileSuccess(profileModel));
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

    emit(ProviderProfileSuccess(
      currentState.profileModel.copyWith(
        data: currentData.copyWith(isFavourite: !previousValue),
      ),
    ));

    try {
      final serverValue = await _repository.toggleFavourite(providerId);
      emit(ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(isFavourite: serverValue),
        ),
      ));
    } catch (e) {
      emit(ProviderProfileSuccess(
        currentState.profileModel.copyWith(
          data: currentData.copyWith(isFavourite: previousValue),
        ),
      ));
      rethrow;
    }
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
}