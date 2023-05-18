import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_data_source.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/update_time_data_source.dart';

final class CurrencyRepositoryImpl implements CurrencyRepository {
  CurrencyRepositoryImpl(this._currencyDataSource, this._updateTimeDataSource);

  static const BOX_NAME = 'Currency';

  UpdateTimeDataSource _updateTimeDataSource;
  CurrencyDataSource _currencyDataSource;

  @override
  Future<int> countVisibleSourceCurrencies() async {
    return _currencyDataSource.countVisibleSourceCurrencies();
  }

  @override
  Future<int> countVisibleTargetCurrencies() async {
    return _currencyDataSource.countVisibleTargetCurrencies();
  }

  @override
  Future<Currency?> loadByCode(String code) async {
    return _currencyDataSource.loadByCode(code);
  }

  @override
  Future<List<Currency>> loadAllCurrencies() async {
    return _currencyDataSource.loadAllCurrencies();
  }

  @override
  Future<List<Currency>> loadCurrenciesByCodeFirstLetter(String letter) async {
    return _currencyDataSource.loadCurrenciesByCodeFirstLetter(letter);
  }

  @override
  Future<List<String>> loadCurrencyCodeFirstLetters() async {
    return _currencyDataSource.loadCurrencyCodeFirstLetters();
  }

  @override
  Future<Map<String, Currency>> loadAllIndexedByCode() async {
    return _currencyDataSource.loadAllIndexedByCode();
  }

  @override
  Future<List<Currency>> loadVisibleSourceCurrencies() async {
    return _currencyDataSource.loadVisibleSourceCurrencies();
  }

  @override
  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    return _currencyDataSource.loadVisibleSourceCurrencyCodes();
  }

  @override
  Future<List<Currency>> loadVisibleTargetCurrencies() async {
    return _currencyDataSource.loadVisibleTargetCurrencies();
  }

  @override
  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    return _currencyDataSource.loadVisibleTargetCurrencyCodes();
  }

  @override
  Future<DateTime?> loadLastUpdateDate() async {
    return _updateTimeDataSource.loadLastUpdateDate();
  }

  @override
  Future<void> save(Currency currency) async {
    return _currencyDataSource.save(currency);
  }

  @override
  Future<void> saveAll(Map<String, Currency> currencies) async {
    return _currencyDataSource.saveAll(currencies);
  }

  @override
  Future<void> saveLastUpdateDateToNow() async {
    return _updateTimeDataSource.saveLastUpdateDateToNow();
  }
}
