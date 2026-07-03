import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart'; 
import 'package:servi_go_app/features/auth/data/models/register_user_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/user_sign_up_response_model.dart';
import 'package:servi_go_app/features/auth/data/repositories/auth_repository.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  final AuthRepository _authRepository;

  RegisterUserCubit(this._authRepository) : super(RegisterUserInitial());

  Future<void> registerUser(RegisterUserRequestBody requestBody) async {
    emit(RegisterUserLoading());

    try {
      final result = await _authRepository.registerUser(requestBody);
      
      
      await PrefHelper.saveString('user_name', requestBody.name ?? 'User');
      
      emit(RegisterUserSuccess(result));
    } on ApiError catch (e) {
      emit(RegisterUserFailure(e));
    } catch (e) {
      emit(RegisterUserFailure(ApiError(message: " unExpected error occured  : $e")));
    }
  }
  
 Future<void> verifyOtp({
  required String email,
  required String otp,
  required String type,
}) async {
  emit(VerifyOtpLoading());
  try {
   
   
    final result = await _authRepository.verifyOtp(
      email: email, 
      otp: otp, 
      type: type,
    );

    emit(VerifyOtpSuccess());
  } on ApiError catch (e) {
    emit(VerifyOtpFailure(e));
  } catch (e) {
    emit(VerifyOtpFailure(ApiError(message: "An unexpected error occurred: $e")));
  }
}

Future<void> resendOtp({
    required String email,
    required String type,
  }) async {
    emit(ResendOtpLoading());
    try {
      await _authRepository.resendOtp(
        email: email,
        type: type,
      );
      emit(ResendOtpSuccess());
    } on ApiError catch (e) {
      emit(ResendOtpFailure(e));
    } catch (e) {
      emit(ResendOtpFailure(ApiError(message: "An unexpected error occurred: $e")));
    }
  }
  Future<void> forgotPassword({
    required String email,
  }) async {
    emit(ForgotPasswordLoading());
    try {
      await _authRepository.forgotPassword(email: email);
      emit(ForgotPasswordSuccess(email));
    } on ApiError catch (e) {
      emit(ForgotPasswordFailure(e));
    } catch (e) {
      emit(
        ForgotPasswordFailure(
          ApiError(message: "An unexpected error occurred: $e"),
        ),
      );
    }
  }

  Future<void> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(ResetPasswordLoading());
    try {
      await _authRepository.resetPassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      emit(ResetPasswordSuccess());
    } on ApiError catch (e) {
      emit(ResetPasswordFailure(e));
    } catch (e) {
      emit(
        ResetPasswordFailure(
          ApiError(message: "An unexpected error occurred: $e"),
        ),
      );
    }
  }
}