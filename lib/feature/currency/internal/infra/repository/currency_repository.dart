import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyRepository {
  static const BOX_NAME = 'Currency';

  Box<Currency>? box;

  Future<CurrencyRepository> init() async {
    if (box == null || box!.isOpen == false) {
      box = await Hive.openBox<Currency>(BOX_NAME);
    }
    return this;
  }

  Future<Currency?> loadByCode(String code) async {
    await init();
    return await box!.get(code);
  }

  Future<void> save(Currency currency) async {
    await init();
    await box!.put(currency.code, currency);
    //await box!.close();
  }

  Future<void> saveAll(Map<String, Currency> currencies) async {
    await init();
    for (var currencyCode in currencies.keys) {
      print("put $currencyCode");
      await box!.put(currencyCode, currencies[currencyCode]!);
    }
    await box!.close();
  }

  // Future<void> close() async {
  //   await box!.close();
  // }

  // int countAll() {
  //   return box!.length;
  // }
  //
  // bool containsKey(String key) {
  //   return box!.containsKey(key);
  // }

  // List<Currency> loadAll() {
  //   return box!.values.toList();
  // }

  Future<List<Currency>> loadAllCurrencies() async {
    await init();
    return box!.values.toList();
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

  Future<int> countVisibleSourceCurrencies() async {
    await init();
    return box!.values
            .where((currency) => currency.isVisibleForSource)
            .length;
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

  Future<int> countVisibleTargetCurrencies() async {
    await init();
    return box!.values
            .where((currency) => currency.isVisibleForTarget)
            .length;
  }

  Future<DateTime?> loadLastUpdateDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('lastUpdateTimestamp')) {
      return null;
    }

    final int lastUpdateTimestamp = prefs.getInt('lastUpdateTimestamp') ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(lastUpdateTimestamp);
  }

  Future<void> saveLastUpdateDateToNow() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final nowTs = DateTime.now().millisecondsSinceEpoch;
    await prefs.setInt('lastUpdateTimestamp', nowTs);
  }
}
