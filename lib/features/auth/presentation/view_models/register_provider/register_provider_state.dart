part of 'register_provider_cubit.dart';

@immutable
sealed class RegisterProviderState {}

final class RegisterProviderInitial extends RegisterProviderState {}

final class RegisterProviderLoading extends RegisterProviderState {}

final class RegisterProviderSuccess extends RegisterProviderState {
  final dynamic response;
  RegisterProviderSuccess(this.response);
}

final class RegisterProviderFailure extends RegisterProviderState {
  final ApiError apiError;
  RegisterProviderFailure(this.apiError);
}
