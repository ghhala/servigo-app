import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:servi_go_app/features/auth/data/models/register_user_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/register_provider_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/user_sign_up_response_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

 
  AuthRepository(this._authRemoteDataSource);

  
  Future<UserSignUpResponseModel> registerUser(RegisterUserRequestBody requestBody) async {
    try {
     
      final rawData = await _authRemoteDataSource.registerUser(requestBody);

      
      return UserSignUpResponseModel.fromJson(rawData);
      
    } on ApiError catch (e) {
    
      throw e;
    } catch (e) {
      
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

  Future<dynamic> registerProvider(RegisterProviderRequestBody requestBody) async {
    try {
      final result = await _authRemoteDataSource.registerProvider(requestBody);
      return result;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }
  
Future<void> verifyOtp({required String email, required String otp}) async {
  try {
    await _authRemoteDataSource.verifyOtp(email: email, otp: otp);
  } on ApiError catch (e) {
    throw e;
  } catch (e) {
    throw ApiError(message: "unExpected error occured processing data : $e");
  }
}

Future<dynamic> login({required String email, required String password}) async {
  try {
    final rawData = await _authRemoteDataSource.login(email: email, password: password);
    return rawData;
  } on ApiError catch (e) {
    throw e;
  } catch (e) {
    throw ApiError(message: "unExpected error occured processing data : $e");
  }
}
  
}