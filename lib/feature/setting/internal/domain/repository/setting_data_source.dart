abstract interface class SettingDataSource {
  Future<String?> getString(String key);
  Future<bool> setString(String key, String value);
  Future<List<String>?> getStringList(String key);
  Future<bool> setStringList(String key, List<String> value);
}