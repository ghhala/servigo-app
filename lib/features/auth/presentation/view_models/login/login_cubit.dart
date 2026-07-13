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
      final result = await _authRepository.login(
        email: email,
        password: password,
      );

      if (result != null && result['success'] == true) {
         await PrefHelper.saveEmail(email);
        emit(LoginSuccess(result));
      } else {
        emit(
          LoginFailure(
            ApiError(
              message: result?['message'] ?? "بيانات تسجيل الدخول غير صحيحة",
            ),
          ),
        );
      }
    } on ApiError catch (e) {
      emit(LoginFailure(e));
    } catch (e) {
      emit(LoginFailure(ApiError(message: "An unexpected error occurred: $e")));
    }
  }
}
