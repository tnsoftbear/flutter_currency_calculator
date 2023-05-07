import 'package:currency_calc/feature/currency/internal/app/init/currency_feature_initializer.dart';
import 'package:currency_calc/feature/currency/internal/app/load/currency_loader.dart';
import 'package:currency_calc/feature/currency/internal/app/populate/currency_populator.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_available_currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';
export "package:currency_calc/feature/currency/internal/domain/model/currency.dart";

class CurrencyFeatureFacade {
  late CurrencyLoader _currencyLoader;

  CurrencyFeatureFacade() {
    CurrencyFeatureInitializer();
    final currencyRepo = CurrencyRepository();
    final currencyFetcher = FawazAhmedAvailableCurrencyFetcher();
    final currencyPopulator = CurrencyPopulator(currencyRepo, currencyFetcher);
    _currencyLoader = CurrencyLoader(currencyRepo, currencyPopulator);
  }

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    return _currencyLoader.loadVisibleSourceCurrencyCodes();
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    return _currencyLoader.loadVisibleTargetCurrencyCodes();
  }

  Future<List<Currency>> loadAllCurrencies() async {
    return _currencyLoader.loadAllCurrencies();
  }
}
