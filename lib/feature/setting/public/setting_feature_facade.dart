import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/setting/internal/app/init/setting_feature_dic.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:currency_calc/feature/setting/internal/ui/screen/setting_screen.dart';

final class SettingFeatureFacade {
  SettingFeatureFacade() {
    this._dic = SettingFeatureDic();
  }

  late SettingFeatureDic _dic;

  SettingScreen createSettingScreen() => const SettingScreen();

  Future<SettingModel> createSettingModel(
      CurrencyFeatureFacade currencyFeatureFacade) async {
    await _dic.initSettingModel(currencyFeatureFacade);
    return _dic.settingModel;
  }
}
