import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/features/user_profile/data/repositories/user_profile_repository.dart';
import 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final UserProfileRepository _repository;

  UserProfileCubit(this._repository) : super(UserProfileInitial());

  Future<void> fetchUserProfile() async {
    emit(UserProfileLoading());
    try {
      final response = await _repository.getUserProfile();
      
     
      if (response.success == true && response.data != null) {
        emit(UserProfileSuccess(response.data!));
      } else {
        emit(UserProfileFailure(response.message ?? "حدث خطأ غير متوقع"));
      }
    } catch (e) {
      
      emit(UserProfileFailure(e.toString()));
    }
  }
}