import 'package:currency_calc/feature/currency/internal/app/populate/currency_populator.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

final class CurrencyLoader {
  CurrencyLoader(this._currencyRepository, this._currencyPopulator);

  final CurrencyRepository _currencyRepository;
  final CurrencyPopulator _currencyPopulator;

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    await _currencyPopulator.populateIfNeeded();
    return await _currencyRepository.loadVisibleSourceCurrencyCodes();
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    await _currencyPopulator.populateIfNeeded();
    return await _currencyRepository.loadVisibleTargetCurrencyCodes();
  }

  Future<List<Currency>> loadAllCurrencies() async {
    await _currencyPopulator.populateIfNeeded();
    return await _currencyRepository.loadAllCurrencies();
  }

  Future<List<Currency>> loadCurrenciesByCodeFirstLetter(String letter) async {
    await _currencyPopulator.populateIfNeeded();
    return await _currencyRepository.loadCurrenciesByCodeFirstLetter(letter);
  }

  Future<List<String>> loadCurrencyCodeFirstLetters() async {
    await _currencyPopulator.populateIfNeeded();
    return await _currencyRepository.loadCurrencyCodeFirstLetters();
  }
}
