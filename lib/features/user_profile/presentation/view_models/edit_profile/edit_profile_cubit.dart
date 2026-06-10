import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/user_profile/data/repositories/user_profile_repository.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserProfileRepository _repository;

  EditProfileCubit(this._repository) : super(EditProfileInitial());

  
  Future<void> updateProfile({
    required String name,
    required String phone,
  }) async {
    emit(EditProfileLoading());
    try {
      final responseModel = await _repository.updateProfile(name: name, phone: phone);
      
     
      await PrefHelper.saveString('user_name', name);

      if (responseModel.success == true) {
        emit(EditProfileSuccess(responseModel));
      } else {
        emit(EditProfileFailure(responseModel.message ?? "Unexpected error occurred"));
      }
    } catch (e) {
      emit(EditProfileFailure(e.toString()));
    }
  }
  Future<void> uploadAvatar({required String imagePath}) async {
    emit(UploadAvatarLoading()); 
    try {
      final response = await _repository.uploadAvatar(imagePath: imagePath);

      if (response != null && response['success'] == true) {
        emit(UploadAvatarSuccess(response));
      } else {
        emit(UploadAvatarFailure(response?['message'] ?? "فشل رفع الصورة"));
      }
    } catch (e) {
      emit(UploadAvatarFailure(e.toString()));
    }
  }
}