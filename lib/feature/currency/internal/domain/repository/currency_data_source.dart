import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';

abstract interface class CurrencyDataSource {
  Future<int> countVisibleSourceCurrencies();

  Future<int> countVisibleTargetCurrencies();

  Future<Currency?> loadByCode(String code);

  Future<List<Currency>> loadAllCurrencies();

  Future<List<Currency>> loadCurrenciesByCodeFirstLetter(String letter);

  Future<List<String>> loadCurrencyCodeFirstLetters();

  Future<Map<String, Currency>> loadAllIndexedByCode();

  Future<List<Currency>> loadVisibleSourceCurrencies();

  Future<List<String>> loadVisibleSourceCurrencyCodes();

  Future<List<Currency>> loadVisibleTargetCurrencies();

  Future<List<String>> loadVisibleTargetCurrencyCodes();

  // Future<DateTime?> loadLastUpdateDate() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('lastUpdateTimestamp')) {
  //     return null;
  //   }
  //
  //   final int lastUpdateTimestamp = prefs.getInt('lastUpdateTimestamp') ?? 0;
  //   return DateTime.fromMillisecondsSinceEpoch(lastUpdateTimestamp);
  // }

  Future<void> save(Currency currency);

  Future<void> saveAll(Map<String, Currency> currencies);

  // Future<void> saveLastUpdateDateToNow() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final currentDateUtcTs = _clock.now().toUtc().millisecondsSinceEpoch;
  //   await prefs.setInt('lastUpdateTimestamp', currentDateUtcTs);
  // }
}
