import 'package:servi_go_app/core/network/api_error.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:servi_go_app/features/auth/data/models/register_user_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/register_provider_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/user_sign_up_response_model.dart';

class AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepository(this._authRemoteDataSource);

  // 1️⃣ دالة تسجيل مستخدم جديد
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

  // 2️⃣ دالة تسجيل مزود خدمة جديد
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
  
  
  Future<dynamic> verifyOtp({
    required String email, 
    required String otp, 
    required String type,
  }) async {
    try {
      final rawData = await _authRemoteDataSource.verifyOtp(
        email: email, 
        otp: otp, 
        type: type,
      );
      
      
      if (rawData != null && rawData['data'] != null && rawData['data']['token'] != null) {
        final String token = rawData['data']['token'].toString();
        await PrefHelper.saveToken(token);
         await PrefHelper.saveEmail(email);
      }

    
      if (rawData != null && rawData['data'] != null) {
        if (rawData['data']['user'] != null && rawData['data']['user']['name'] != null) {
          await PrefHelper.saveString('user_name', rawData['data']['user']['name'].toString());
        } else if (rawData['data']['name'] != null) {
          await PrefHelper.saveString('user_name', rawData['data']['name'].toString());
        }
      }

      return rawData;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }
   Future<dynamic> resendOtp({
    required String email,
    required String type,
  }) async {
    try {
      final rawData = await _authRemoteDataSource.resendOtp(
        email: email,
        type: type,
      );
      return rawData;
    } on ApiError catch (e) {
      throw e;
    } catch (e) {
      throw ApiError(message: "unExpected error occured processing data : $e");
    }
  }

 Future<dynamic> login({
  required String email, 
  required String password,
}) async {
  try {
    final rawData = await _authRemoteDataSource.login(
      email: email, 
      password: password,
    );

    if (rawData != null && rawData['data'] != null && rawData['data']['token'] != null) {
      final String token = rawData['data']['token'].toString();
      await PrefHelper.saveToken(token);
      await PrefHelper.saveEmail(email); 
    }

    return rawData;
  } on ApiError catch (e) {
    throw e;
  } catch (e) {
    throw ApiError(message: "unExpected error occured processing data : $e");
  }
}
}