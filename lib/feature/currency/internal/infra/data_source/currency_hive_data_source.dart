import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrencyHiveDataSource implements CurrencyDataSource {
  CurrencyHiveDataSource();

  static const BOX_NAME = 'Currency';

  Box<Currency>? box;

  Future<CurrencyHiveDataSource> init() async {
    if (box == null || box!.isOpen == false) {
      box = await Hive.openBox<Currency>(BOX_NAME);
    }
    return this;
  }

  Future<int> countVisibleSourceCurrencies() async {
    await init();
    return box!.values.where((currency) => currency.isVisibleForSource).length;
  }

  Future<int> countVisibleTargetCurrencies() async {
    await init();
    return box!.values.where((currency) => currency.isVisibleForTarget).length;
  }

  Future<Currency?> loadByCode(String code) async {
    await init();
    return await box!.get(code);
  }

  Future<List<Currency>> loadAllCurrencies() async {
    await init();
    return box!.values.toList();
  }

  Future<List<Currency>> loadCurrenciesByCodeFirstLetter(String letter) async {
    await init();
    return box!.values
        .where((currency) => currency.code.startsWith(letter))
        .toList();
  }

  Future<List<String>> loadCurrencyCodeFirstLetters() async {
    await init();
    return box!.values
        .map((currency) => currency.code.substring(0, 1))
        .toSet()
        .toList();
  }

  Future<Map<String, Currency>> loadAllIndexedByCode() async {
    await init();
    return {for (var currency in box!.values) currency.code: currency};
  }

  Future<List<Currency>> loadVisibleSourceCurrencies() async {
    await init();
    return box!.values
        .where((currency) => currency.isVisibleForSource)
        .toList();
  }

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    await init();
    return box!.values
        .where((currency) => currency.isVisibleForSource)
        .map((currency) => currency.code)
        .toList();
  }

  Future<List<Currency>> loadVisibleTargetCurrencies() async {
    await init();
    return box!.values
        .where((currency) => currency.isVisibleForTarget)
        .toList();
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    await init();
    return box!.values
        .where((currency) => currency.isVisibleForTarget)
        .map((currency) => currency.code)
        .toList();
  }

  // Future<DateTime?> loadLastUpdateDate() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (!prefs.containsKey('lastUpdateTimestamp')) {
  //     return null;
  //   }
  //
  //   final int lastUpdateTimestamp = prefs.getInt('lastUpdateTimestamp') ?? 0;
  //   return DateTime.fromMillisecondsSinceEpoch(lastUpdateTimestamp);
  // }

  Future<void> save(Currency currency) async {
    await init();
    await box!.put(currency.code, currency);
    print(
        'saved ${currency.code} and ${currency.isVisibleForSource} isVisibleForSource and ${currency.isVisibleForTarget} isVisibleForTarget');
  }

  Future<void> saveAll(Map<String, Currency> currencies) async {
    await init();
    for (var currencyCode in currencies.keys) {
      await box!.put(currencyCode, currencies[currencyCode]!);
    }
  }

// Future<void> saveLastUpdateDateToNow() async {
//   final SharedPreferences prefs = await SharedPreferences.getInstance();
//   final currentDateUtcTs = _clock.now().toUtc().millisecondsSinceEpoch;
//   await prefs.setInt('lastUpdateTimestamp', currentDateUtcTs);
// }
}
