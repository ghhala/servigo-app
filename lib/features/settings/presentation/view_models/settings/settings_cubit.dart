import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/settings/data/repositories/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

  SettingsCubit({required this.repository}) : super(SettingsState());

  // ── Logout ──
  Future<void> logout() async {
    emit(state.copyWith(status: SettingsStatus.loading));
    try {
      await repository.logout();
      await PrefHelper.clearToken(); 
      await PrefHelper.clearEmail();
      emit(state.copyWith(
        status: SettingsStatus.success,
        isLoggedOut: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SettingsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ── Delete Account ──
  Future<void> deleteAccount() async {
  emit(state.copyWith(status: SettingsStatus.loading));
  try {
    await repository.deleteAccountRequest();
    emit(state.copyWith(
      status: SettingsStatus.success,
      otpSentForDeletion: true, 
    ));
  } catch (e) {
    emit(state.copyWith(
      status: SettingsStatus.error,
      errorMessage: e.toString(),
    ));
  }

}
Future<void> confirmDeleteAccount({
  required String email,
  required String code,
}) async {
  emit(state.copyWith(status: SettingsStatus.loading));
  try {
    await repository.verifyDeleteAccountOtp(email: email, code: code);
    await PrefHelper.clearToken();
    emit(state.copyWith(
      status: SettingsStatus.success,
      isAccountDeleted: true,
    ));
  } catch (e) {
    emit(state.copyWith(
      status: SettingsStatus.error,
      errorMessage: e.toString(),
    ));
  }
}


  // ── Available Now Toggle ──
  Future<void> toggleAvailability(bool value) async {
    final oldValue = state.isAvailable;
    // ✅ تحديث متفائل (Optimistic UI) فوراً
    emit(state.copyWith(isAvailable: value));
    try {
      await repository.updateAvailability(isAvailable: value);
    } catch (e) {
      // ❌ رجوع للقيمة القديمة لو فشل الطلب
      emit(state.copyWith(
        isAvailable: oldValue,
        status: SettingsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  // ── Overnight Toggle ──
  Future<void> toggleOvernight(bool value) async {
    final oldValue = state.overnight;
    emit(state.copyWith(overnight: value));
    try {
      await repository.updateAvailability(overnight: value);
    } catch (e) {
      emit(state.copyWith(
        overnight: oldValue,
        status: SettingsStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}