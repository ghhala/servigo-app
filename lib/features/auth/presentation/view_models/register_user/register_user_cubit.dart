import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/network/api_error.dart';
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
      
      
      emit(RegisterUserSuccess(result));
    } on ApiError catch (e) {
      
      emit(RegisterUserFailure(e));
    } catch (e) {
      
      emit(RegisterUserFailure(ApiError(message: " unExpected error occured  : $e")));
    }
  }
}