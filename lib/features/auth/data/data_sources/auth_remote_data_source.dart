import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/features/auth/data/models/register_user_request_body.dart';

class AuthRemoteDataSource {
  final ApiService _apiService;

  AuthRemoteDataSource(this._apiService);

  Future<dynamic> registerUser(RegisterUserRequestBody requestBody) async {
    final response = await _apiService.post(
      'auth/register/user',
      requestBody.toJson(),
    );

    return response;
  }

  Future<dynamic> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response = await _apiService.post('auth/verify-otp', {
      'email': email,
      'code': otp.toString(),
      'type': 'register',
    });
    return response;
  }
}
