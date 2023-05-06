import 'package:currency_calc/feature/currency/internal/app/populate/currency_populator.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

class CurrencyLoader {
  static Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    if (true) { // TODO: check if loaded currencies TTL is not expired
      await CurrencyPopulator.populate();
    }
    CurrencyRepository currencyRepo = CurrencyRepository();
    return await currencyRepo.loadVisibleSourceCurrencyCodes();
  }

  static Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    if (true) { // TODO: check if loaded currencies TTL is not expired
      await CurrencyPopulator.populate();
    }
    CurrencyRepository currencyRepo = CurrencyRepository();
    return await currencyRepo.loadVisibleTargetCurrencyCodes();
  }

  static Future<List<String>> loadAllCurrencyCodes() async {
    if (true) { // TODO: check if loaded currencies TTL is not expired
      await CurrencyPopulator.populate();
    }
    CurrencyRepository currencyRepo = CurrencyRepository();
    return await currencyRepo.loadAllCurrencyCodes();
  }
}
