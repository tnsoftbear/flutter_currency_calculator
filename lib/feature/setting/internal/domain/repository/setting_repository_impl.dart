import 'package:currency_calc/feature/setting/internal/domain/repository/setting_data_source.dart';
import 'package:currency_calc/feature/setting/internal/domain/repository/setting_repository.dart';

final class SettingRepositoryImpl implements SettingRepository {
  SettingRepositoryImpl(this._settingDataSource);

  SettingDataSource _settingDataSource;

  Future<String?> loadString(String key) async {
    return await _settingDataSource.getString(key);
  }

  Future<void> saveString(String key, String value) async {
    await _settingDataSource.setString(key, value);
  }

  Future<List<String>?> loadVisibleSourceCurrencyCodes() async {
    return await _settingDataSource.getStringList("visibleSourceCurrencyCodes");
  }

  Future<void> saveVisibleSourceCurrencyCodes(
      List<String> currencyCodes) async {
    await _settingDataSource.setStringList(
        "visibleSourceCurrencyCodes", currencyCodes);
  }

  Future<List<String>?> loadVisibleTargetCurrencyCodes() async {
    return await _settingDataSource.getStringList("visibleTargetCurrencyCodes");
  }

  Future<void> saveVisibleTargetCurrencyCodes(
      List<String> currencyCodes) async {
    await _settingDataSource.setStringList(
        "visibleTargetCurrencyCodes", currencyCodes);
  }
}
