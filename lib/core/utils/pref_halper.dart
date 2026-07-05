import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tokenKey = 'auth_token';
  static const String _emailKey = 'user_email';
  static late SharedPreferences _prefs;


  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  
  static Future<bool> saveToken(String token) async {
    return await _prefs.setString(_tokenKey, token);
  }


  static String? getToken() {
    return _prefs.getString(_tokenKey);
  }

 
  static Future<bool> clearToken() async {
    return await _prefs.remove(_tokenKey);
  }
 
  static Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  
  static String? getString(String key) {
    return _prefs.getString(key);
  }
  static Future<void> saveUserImage(String imageUrl) async {
    await _prefs.setString('user_image', imageUrl);
  }

 
  static String getUserImage() {
    return _prefs.getString('user_image') ?? '';
  }
  static Future<bool> clearUserImage() async {
    return await _prefs.remove('user_image');
  }

  static Future<bool> saveEmail(String email) async {
    return await _prefs.setString(_emailKey, email);
  }

  static String? getEmail() {
    return _prefs.getString(_emailKey);
  }

  static Future<bool> clearEmail() async {
    return await _prefs.remove(_emailKey);
  }
  static Future<void> clearAllUserData() async {
    await _prefs.remove(_tokenKey);
    await _prefs.remove(_emailKey);
    await _prefs.remove('user_image');
    await _prefs.remove('user_name');
  }
}