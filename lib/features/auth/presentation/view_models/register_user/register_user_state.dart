part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState {}


final class RegisterUserInitial extends RegisterUserState {}


final class RegisterUserLoading extends RegisterUserState {}


final class RegisterUserSuccess extends RegisterUserState {
  final UserSignUpResponseModel response;
  RegisterUserSuccess(this.response);
}


final class RegisterUserFailure extends RegisterUserState {
  final ApiError error;
  RegisterUserFailure(this.error);

}
final class VerifyOtpLoading extends RegisterUserState {}

final class VerifyOtpSuccess extends RegisterUserState {}

final class VerifyOtpFailure extends RegisterUserState {
  final ApiError error;
  VerifyOtpFailure(this.error);
}