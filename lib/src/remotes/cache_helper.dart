import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static dynamic getData({required String key}) {
    return _sharedPreferences.get(key);
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await _sharedPreferences.setBool(key, value);
  }

  static Future<bool> putInt({required String key, required int value}) async {
    return await _sharedPreferences.setInt(key, value);
  }

  static Future<bool> putDouble(
      {required String key, required double value}) async {
    return await _sharedPreferences.setDouble(key, value);
  }

  static Future<bool> putString(
      {required String key, required String value}) async {
    return await _sharedPreferences.setString(key, value);
  }

  static Future<bool> removeData({required String key}) async {
    return await _sharedPreferences.remove(key);
  }
}
