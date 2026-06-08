import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/auth/data/repositories/auth_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    try {
      final result = await _authRepository.login(email: email, password: password);
      
      
      if (result != null && result['data'] != null && result['data']['token'] != null) {
        final String token = result['data']['token'].toString();
        await PrefHelper.saveToken(token); // 🌟 الدالة المطابقة للـ DioClient تماماً
      }

      emit(LoginSuccess(result));
    } on ApiError catch (e) {
      emit(LoginFailure(e));
    } catch (e) {
      emit(LoginFailure(ApiError(message: "An unexpected error occurred: $e")));
    }
  }
}