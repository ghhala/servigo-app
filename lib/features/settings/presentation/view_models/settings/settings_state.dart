enum SettingsStatus { initial, loading, success, error }

class SettingsState {
  final SettingsStatus status;
  final bool isAvailable;
  final bool overnight;
  final String? errorMessage;
  final bool isLoggedOut;
  final bool isAccountDeleted;
  final bool otpSentForDeletion; 

  SettingsState({
    this.status = SettingsStatus.initial,
    this.isAvailable = false,
    this.overnight = false,
    this.errorMessage,
    this.isLoggedOut = false,
    this.isAccountDeleted = false,
    this.otpSentForDeletion = false,
  });

  SettingsState copyWith({
    SettingsStatus? status,
    bool? isAvailable,
    bool? overnight,
    String? errorMessage,
    bool? isLoggedOut,
    bool? isAccountDeleted,
     bool? otpSentForDeletion,
  }) {
    return SettingsState(
      status: status ?? this.status,
      isAvailable: isAvailable ?? this.isAvailable,
      overnight: overnight ?? this.overnight,
      errorMessage: errorMessage,
      isLoggedOut: isLoggedOut ?? this.isLoggedOut,
      isAccountDeleted: isAccountDeleted ?? this.isAccountDeleted,
       otpSentForDeletion: otpSentForDeletion ?? this.otpSentForDeletion,
    );
  }
}