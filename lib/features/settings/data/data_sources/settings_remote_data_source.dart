import 'package:servi_go_app/core/network/api_service.dart';

class SettingsRemoteDataSource {
  final ApiService apiService;

  SettingsRemoteDataSource({required this.apiService});

  // ── Logout ──
  Future<void> logout() async {
    await apiService.post('auth/logout', null);
  }

  // ── Delete Account ──
  Future<void> deleteAccountRequest() async {
    await apiService.post('auth/delete-account-request', null);
  }
  Future<void> verifyDeleteAccountOtp({
  required String email,
  required String code,
}) async {
  await apiService.post('auth/verify-otp', {
    'email': email,
    'code': code,
    'type': 'delete_account',
  });
}

 
  Future<void> updateAvailability({
    bool? isAvailable,
    bool? overnight,
  }) async {
    final Map<String, dynamic> body = {};
    if (isAvailable != null) body['is_available'] = isAvailable;
    if (overnight != null) body['overnight'] = overnight;

    await apiService.put('provider/profile', body);
  }
}