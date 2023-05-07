import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_initializer.dart';
import 'package:currency_calc/feature/currency/internal/app/load/currency_loader.dart';

class CurrencyFeatureFacade {
  CurrencyFeatureFacade() {
    CurrencyFeatureInitializer();
  }

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    return CurrencyLoader.loadVisibleSourceCurrencyCodes();
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    return CurrencyLoader.loadVisibleTargetCurrencyCodes();
  }

  Future<List<String>> loadAllCurrencyCodes() async {
    return CurrencyLoader.loadAllCurrencyCodes();
  }
}