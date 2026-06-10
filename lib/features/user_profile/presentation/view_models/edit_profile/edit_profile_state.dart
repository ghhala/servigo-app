import 'package:servi_go_app/features/user_profile/data/models/edit_profile_response_model.dart';


abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class EditProfileLoading extends EditProfileState {}
class EditProfileSuccess extends EditProfileState {
  final EditProfileResponseModel responseModel;
  EditProfileSuccess(this.responseModel);
}
class EditProfileFailure extends EditProfileState {
  final String errorMessage;
  EditProfileFailure(this.errorMessage);
}
class UploadAvatarLoading extends EditProfileState {}

class UploadAvatarSuccess extends EditProfileState {
  final dynamic response;
  UploadAvatarSuccess(this.response);
}

class UploadAvatarFailure extends EditProfileState {
  final String errorMessage;
  UploadAvatarFailure(this.errorMessage);
}