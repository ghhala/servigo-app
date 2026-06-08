import 'package:servi_go_app/core/network/api_service.dart';
import 'package:servi_go_app/features/auth/data/models/register_user_request_body.dart';
import 'package:servi_go_app/features/auth/data/models/register_provider_request_body.dart';

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

  Future<dynamic> registerProvider(RegisterProviderRequestBody requestBody) async {
    final formData = await requestBody.toFormData();
    final response = await _apiService.postFormData(
      'auth/register/provider',
      formData,
    );

    return response;
  }


  Future<dynamic> verifyOtp({
    required String email,
    required String otp,
    required String type,
  }) async {
    final response = await _apiService.post('auth/verify-otp', {
      'email': email,
      'code': otp.toString(),
      'type': type,
    });
    return response;
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.post('auth/login', {
      'email': email,
      'password': password,
    });
    return response;
  }
}
