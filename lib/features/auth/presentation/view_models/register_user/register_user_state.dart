part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {}

final class RegisterUserInitial extends RegisterUserState {}

/// =======================
/// Register User States
/// =======================
final class RegisterUserLoading extends RegisterUserState {}

final class RegisterUserSuccess extends RegisterUserState {
  final UserSignUpResponseModel response;
  RegisterUserSuccess(this.response);
}

final class RegisterUserFailure extends RegisterUserState {
  final ApiError error;
  RegisterUserFailure(this.error);
}

/// =======================
/// Verify OTP States
/// =======================
final class VerifyOtpLoading extends RegisterUserState {}

final class VerifyOtpSuccess extends RegisterUserState {}

final class VerifyOtpFailure extends RegisterUserState {
  final ApiError error;
  VerifyOtpFailure(this.error);
}

/// =======================
/// Resend OTP States
/// =======================
final class ResendOtpLoading extends RegisterUserState {}

final class ResendOtpSuccess extends RegisterUserState {}

final class ResendOtpFailure extends RegisterUserState {
  final ApiError error;
  ResendOtpFailure(this.error);
}

/// =======================
/// Forgot Password States
/// =======================
final class ForgotPasswordLoading extends RegisterUserState {}

final class ForgotPasswordSuccess extends RegisterUserState {
  final String email;
  ForgotPasswordSuccess(this.email);
}

final class ForgotPasswordFailure extends RegisterUserState {
  final ApiError error;
  ForgotPasswordFailure(this.error);
}

/// =======================
/// Reset Password States
/// =======================
final class ResetPasswordLoading extends RegisterUserState {}

final class ResetPasswordSuccess extends RegisterUserState {}

final class ResetPasswordFailure extends RegisterUserState {
  final ApiError error;
  ResetPasswordFailure(this.error);
}