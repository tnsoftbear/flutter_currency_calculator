import 'package:currency_calc/feature/setting/internal/domain/repository/setting_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class SettingSharedPrefsDataSource implements SettingDataSource {
  Future<SharedPreferences> getInstance() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<String?> getString(String key) async {
    final prefs = await getInstance();
    return prefs.getString(key);
  }

  @override
  Future<bool> setString(String key, String value) async {
    final prefs = await getInstance();
    return await prefs.setString(key, value);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    final prefs = await getInstance();
    return prefs.getStringList(key);
  }

  @override
  Future<bool> setStringList(String key, List<String> value) async {
    final prefs = await getInstance();
    return await prefs.setStringList(key, value);
  }
}
