import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('en'));

  static const _storageKey = 'app_locale';
  static const _supportedLocales = ['en', 'ar'];

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final storedCode = prefs.getString(_storageKey);
    if (storedCode == null || !_supportedLocales.contains(storedCode)) {
      return;
    }
    emit(Locale(storedCode));
  }

  Future<void> toggleLocale() async {
    final nextCode = state.languageCode == 'ar' ? 'en' : 'ar';
    await setLocale(Locale(nextCode));
  }

  Future<void> setLocale(Locale locale) async {
    emit(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, locale.languageCode);
  }
}
