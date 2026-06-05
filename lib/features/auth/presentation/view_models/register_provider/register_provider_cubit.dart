import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/features/auth/data/models/register_provider_request_body.dart';
import 'package:servi_go_app/features/auth/data/repositories/auth_repository.dart';

part 'register_provider_state.dart';

class RegisterProviderCubit extends Cubit<RegisterProviderState> {
  final AuthRepository _authRepository;

  RegisterProviderCubit(this._authRepository) : super(RegisterProviderInitial());

  Future<void> registerProvider(RegisterProviderRequestBody requestBody) async {
    emit(RegisterProviderLoading());

    try {
      final result = await _authRepository.registerProvider(requestBody);
      emit(RegisterProviderSuccess(result));
    } on ApiError catch (e) {
      emit(RegisterProviderFailure(e));
    } catch (e) {
      emit(RegisterProviderFailure(
        ApiError(message: "An unexpected error occurred: $e"),
      ));
    }
  }
}
