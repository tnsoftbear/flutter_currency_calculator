import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_dic.dart';
import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_initializer.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_setting_widget.dart';
export "package:currency_calc/feature/currency/internal/domain/model/currency.dart";

class CurrencyFeatureFacade {
  late CurrencyFeatureDic _dic;

  CurrencyFeatureFacade(CurrencyFeatureDic this._dic) {
    CurrencyFeatureInitializer();
  }

  Future<void> populateIfNeeded() async {
    await _dic.currencyPopulator.populateIfNeeded();
  }

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    return _dic.currencyLoader.loadVisibleSourceCurrencyCodes();
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    return _dic.currencyLoader.loadVisibleTargetCurrencyCodes();
  }

  // Future<List<Currency>> loadCurrenciesByCodeFirstLetter(String letter) async {
  //   return _dic.currencyLoader.loadCurrenciesByCodeFirstLetter(letter);
  // }

  Future<List<String>> loadCurrencyCodeFirstLetters() async {
    return _dic.currencyLoader.loadCurrencyCodeFirstLetters();
  }

  CurrencySettingWidget createCurrencySettingWidget() {
    return CurrencySettingWidget(_dic.currencyLoader, _dic.currencyRepository);
  }
}
