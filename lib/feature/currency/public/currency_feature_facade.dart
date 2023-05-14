import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_dic.dart';
import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_initializer.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_setting_widget.dart';
export "package:currency_calc/feature/currency/internal/domain/model/currency.dart";

class CurrencyFeatureFacade {
  CurrencyFeatureFacade(CurrencyFeatureDic this._dic) {
    CurrencyFeatureInitializer();
  }

  late final CurrencyFeatureDic _dic;

  /**
   * Update currency DB with new fetched currencies, if time has come.
   */
  Future<void> populateIfNeeded() async {
    await _dic.currencyPopulator.populateIfNeeded();
  }

  /**
   * Load currency codes of visible currencies for the source currency.
   */
  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    return _dic.currencyLoader.loadVisibleSourceCurrencyCodes();
  }

  /**
   * Load currency codes of visible currencies for the target currency.
   */
  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    return _dic.currencyLoader.loadVisibleTargetCurrencyCodes();
  }

  /**
   * Create a widget for currencies configuration.
   */
  CurrencySettingWidget createCurrencySettingWidget() {
    return CurrencySettingWidget(
        _dic.currencyLoader, _dic.currencyVisibilityUpdater);
  }
}
