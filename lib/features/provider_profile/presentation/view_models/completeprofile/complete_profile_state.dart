import 'package:servi_go_app/features/provider_profile/data/models/complete_profile_response.dart';


abstract class CompleteProfileState {}

class CompleteProfileInitial extends CompleteProfileState {}

class CompleteProfileLoading extends CompleteProfileState {}

class CompleteProfileSuccess extends CompleteProfileState {
 
  final CompleteProfileResponse response;

  CompleteProfileSuccess(this.response);
}

class CompleteProfileFailure extends CompleteProfileState {
  final String errorMessage;

  CompleteProfileFailure(this.errorMessage);
}