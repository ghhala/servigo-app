import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String _tokenKey = 'auth_token';
  static late SharedPreferences _prefs;


  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  
  static Future<bool> saveToken(String token) async {
    return await _prefs.setString(_tokenKey, token);
  }

  // 3. دالة جلب التوكن (أصبحت سريعة ومباشرة بدون Future أو async!)
  static String? getToken() {
    return _prefs.getString(_tokenKey);
  }

  // 4. دالة حذف التوكن عند تسجيل الخروج
  static Future<bool> clearToken() async {
    return await _prefs.remove(_tokenKey);
  }
 
  static Future<bool> saveString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  
  static String? getString(String key) {
    return _prefs.getString(key);
  }
}