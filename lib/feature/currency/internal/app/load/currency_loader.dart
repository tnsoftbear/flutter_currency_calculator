import 'package:currency_calc/feature/currency/internal/app/populate/currency_populator.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

class CurrencyLoader {
  final CurrencyRepository currencyRepository;
  final CurrencyPopulator currencyPopulator;

  CurrencyLoader(this.currencyRepository, this.currencyPopulator);

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    await currencyPopulator.populateIfNeeded();
    return await currencyRepository.loadVisibleSourceCurrencyCodes();
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    await currencyPopulator.populateIfNeeded();
    return await currencyRepository.loadVisibleTargetCurrencyCodes();
  }

  Future<List<Currency>> loadAllCurrencies() async {
    await currencyPopulator.populateIfNeeded();
    return await currencyRepository.loadAllCurrencies();
  }
}
