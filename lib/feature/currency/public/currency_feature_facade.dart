import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_initializer.dart';
import 'package:currency_calc/feature/currency/internal/app/load/currency_loader.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';

export "package:currency_calc/feature/currency/internal/domain/model/currency.dart";

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

  Future<List<Currency>> loadAllCurrencies() async {
    return CurrencyLoader.loadAllCurrencies();
  }
}