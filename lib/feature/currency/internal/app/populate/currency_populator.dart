import 'package:currency_calc/feature/currency/internal/domain/collect/currency_collector.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_available_currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

class CurrencyPopulator {
  static Future<void> populate() async {
    final fetchedCurrencies =
        await FawazAhmedAvailableCurrencyFetcher().fetchAvailableCurrencies();
    final currencyRepo = CurrencyRepository();
    final existingCurrencies = await currencyRepo.loadAllIndexedByCode();
    final CurrencyMap newCurrencies =
        CurrencyCollector.collectMissingCurrencies(
            existingCurrencies, fetchedCurrencies);
    CurrencyCollector.applyVisibility(newCurrencies);
    await currencyRepo.saveAll(newCurrencies);
  }
}
