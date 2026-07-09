import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:servi_go_app/core/utils/pref_halper.dart';
import 'package:servi_go_app/features/settings/data/repositories/settings_repository.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final SettingsRepository repository;

 
  final void Function(bool value)? onAvailabilityChanged;
  final void Function(bool value)? onOvernightChanged;

  SettingsCubit({
    required this.repository,
    this.onAvailabilityChanged,
    this.onOvernightChanged,
  }) : super(SettingsState());

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
   
    emit(state.copyWith(isAvailable: value));
    onAvailabilityChanged?.call(value);
    try {
      await repository.updateAvailability(isAvailable: value);
    } catch (e) {
     
      emit(state.copyWith(
        isAvailable: oldValue,
        status: SettingsStatus.error,
        errorMessage: e.toString(),
      ));
      onAvailabilityChanged?.call(oldValue);
    }
  }

  // ── Overnight Toggle ──
  Future<void> toggleOvernight(bool value) async {
    final oldValue = state.overnight;
    emit(state.copyWith(overnight: value));
    onOvernightChanged?.call(value);
    try {
      await repository.updateAvailability(overnight: value);
    } catch (e) {
      emit(state.copyWith(
        overnight: oldValue,
        status: SettingsStatus.error,
        errorMessage: e.toString(),
      ));
      onOvernightChanged?.call(oldValue);
    }
  }
}