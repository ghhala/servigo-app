
import 'package:servi_go_app/features/user_profile/data/models/user_profile_model.dart';

abstract class UserProfileState {}

class UserProfileInitial extends UserProfileState {}
class UserProfileLoading extends UserProfileState {}
class UserProfileSuccess extends UserProfileState {
  final UserProfileData userData;
  UserProfileSuccess(this.userData);
}
class UserProfileFailure extends UserProfileState {
  final String errorMessage;
  UserProfileFailure(this.errorMessage);
}