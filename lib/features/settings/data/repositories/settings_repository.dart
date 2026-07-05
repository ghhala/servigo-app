import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/settings/data/data_sources/settings_remote_data_source.dart';

class SettingsRepository {
  final SettingsRemoteDataSource remoteDataSource;

  SettingsRepository({required this.remoteDataSource});

  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      rethrow;
    } finally {
      
      await PrefHelper.clearAllUserData();
    }
  }

  Future<void> deleteAccountRequest() async {
    try {
      await remoteDataSource.deleteAccountRequest();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> verifyDeleteAccountOtp({
    required String email,
    required String code,
  }) async {
    try {
      await remoteDataSource.verifyDeleteAccountOtp(
        email: email,
        code: code,
      );
    } catch (e) {
      rethrow;
    } finally {
      // ✅ حذف الحساب = يجب مسح البيانات المحلية كمان
      await PrefHelper.clearAllUserData();
    }
  }

  Future<void> updateAvailability({
    bool? isAvailable,
    bool? overnight,
  }) async {
    try {
      await remoteDataSource.updateAvailability(
        isAvailable: isAvailable,
        overnight: overnight,
      );
    } catch (e) {
      rethrow;
    }
  }
}