import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
    return await box!.get(code);
  }

  // Future<void> saveByCode(String code, Currency currency) async {
  //   await box!.put(code, currency);
  //   //await box!.close();
  // }

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

  Future<Map<String, Currency>> loadAllIndexedByCode() async {
    await init();
    return {for (var currency in box!.values) currency.code: currency};
  }

  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    await init();
    return box!.values
            .where((currency) => currency.isVisibleForSource)
            .map((currency) => currency.code)
            .toList() ??
        [];
  }

  Future<List<String>> loadAllCurrencyCodes() async {
    await init();
    return box!.values
        .map((currency) => currency.code)
        .toList() ??
        [];
  }

  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    await init();
    return box!.values
            .where((currency) => currency.isVisibleForTarget)
            .map((currency) => currency.code)
            .toList() ??
        [];
  }
}
