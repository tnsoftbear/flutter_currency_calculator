abstract interface class SettingRepository {
  Future<String?> loadString(String key);

  Future<void> saveString(String key, String value);

  Future<List<String>?> loadVisibleSourceCurrencyCodes();

  Future<void> saveVisibleSourceCurrencyCodes(List<String> currencyCodes);

  Future<List<String>?> loadVisibleTargetCurrencyCodes();

  Future<void> saveVisibleTargetCurrencyCodes(List<String> currencyCodes);
}
