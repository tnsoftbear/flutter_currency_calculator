import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_dic.dart';
import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_initializer.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_setting_widget.dart';
export "package:currency_calc/feature/currency/internal/domain/model/currency.dart";

class CurrencyFeatureFacade {
  CurrencyFeatureFacade(CurrencyFeatureDic this._dic) {
    CurrencyFeatureInitializer();
  }

  late final CurrencyFeatureDic _dic;

  Future<void> populateIfNeeded() async {
    await _dic.currencyPopulator.populateIfNeeded();
  }

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    return _dic.currencyLoader.loadVisibleSourceCurrencyCodes();
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    return _dic.currencyLoader.loadVisibleTargetCurrencyCodes();
  }

  CurrencySettingWidget createCurrencySettingWidget() {
    return CurrencySettingWidget(
        _dic.currencyLoader, _dic.currencyVisibilityUpdater);
  }
}
