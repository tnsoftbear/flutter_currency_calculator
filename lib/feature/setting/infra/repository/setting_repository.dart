import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  static Future<String?> loadString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(key);
  }

  static Future<void> saveString(String key, String value) async {
    await SharedPreferences.getInstance()
      ..setString(key, value);
  }
}