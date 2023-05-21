import 'dart:developer';

import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrencyHiveDataSource implements CurrencyDataSource {
  CurrencyHiveDataSource();

  static const BOX_NAME = 'Currency';

  Box<Currency>? box;

  Future<CurrencyHiveDataSource> _init() async {
    if (box == null || box!.isOpen == false) {
      box = await Hive.openBox<Currency>(BOX_NAME);
    }
    return this;
  }

  @override
  Future<int> countVisibleSourceCurrencies() async {
    await _init();
    return box!.values.where((currency) => currency.isVisibleForSource).length;
  }

  @override
  Future<int> countVisibleTargetCurrencies() async {
    await _init();
    return box!.values.where((currency) => currency.isVisibleForTarget).length;
  }

  @override
  Future<Currency?> loadByCode(String code) async {
    await _init();
    return await box!.get(code);
  }

  @override
  Future<List<Currency>> loadAllCurrencies() async {
    await _init();
    return box!.values.toList();
  }

  @override
  Future<List<Currency>> loadCurrenciesByCodeFirstLetter(String letter) async {
    await _init();
    return box!.values
        .where((currency) => currency.code.startsWith(letter))
        .toList();
  }

  @override
  Future<List<String>> loadCurrencyCodeFirstLetters() async {
    await _init();
    return box!.values
        .map((currency) => currency.code.substring(0, 1))
        .toSet()
        .toList();
  }

  @override
  Future<Map<String, Currency>> loadAllIndexedByCode() async {
    await _init();
    return {for (var currency in box!.values) currency.code: currency};
  }

  @override
  Future<List<Currency>> loadVisibleSourceCurrencies() async {
    await _init();
    return box!.values
        .where((currency) => currency.isVisibleForSource)
        .toList();
  }

  @override
  Future<List<String>> loadVisibleSourceCurrencyCodes() async {
    await _init();
    return box!.values
        .where((currency) => currency.isVisibleForSource)
        .map((currency) => currency.code)
        .toList();
  }

  @override
  Future<List<Currency>> loadVisibleTargetCurrencies() async {
    await _init();
    return box!.values
        .where((currency) => currency.isVisibleForTarget)
        .toList();
  }

  @override
  Future<List<String>> loadVisibleTargetCurrencyCodes() async {
    await _init();
    return box!.values
        .where((currency) => currency.isVisibleForTarget)
        .map((currency) => currency.code)
        .toList();
  }

  @override
  Future<void> save(Currency currency) async {
    await _init();
    await box!.put(currency.code, currency);
    log('saved ${currency.code} and isVisibleForSource: ${currency.isVisibleForSource} ' +
        ' and isVisibleForTarget: ${currency.isVisibleForTarget}');
  }

  @override
  Future<void> saveAll(Map<String, Currency> currencies) async {
    await _init();
    for (var currencyCode in currencies.keys) {
      await box!.put(currencyCode, currencies[currencyCode]!);
    }
  }
}
