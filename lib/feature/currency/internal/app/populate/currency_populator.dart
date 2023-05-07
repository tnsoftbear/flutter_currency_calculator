import 'dart:developer';

import 'package:currency_calc/feature/currency/internal/domain/collect/currency_collector.dart';
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

class CurrencyPopulator {
  static const POPULATION_INTERVAL_IN_DAYS = 7;

  CurrencyRepository _currencyRepository;
  CurrencyFetcher _currencyFetcher;

  CurrencyPopulator(this._currencyRepository, this._currencyFetcher);

  Future<void> populateIfNeeded() async {
    if (await mustPopulate()) {
      await populate();
    }
  }

  Future<bool> mustPopulate() async {
    final lastUpdateDate = await _currencyRepository.loadLastUpdateDate();
    if (lastUpdateDate == null) {
      return true;
    }

    final differenceInSec = DateTime.now().difference(lastUpdateDate).inSeconds;
    return differenceInSec > POPULATION_INTERVAL_IN_DAYS * 24 * 60 * 60;
  }

  Future<void> populate() async {
    final fetchedCurrencies = await _currencyFetcher.fetchAvailableCurrencies();
    final existingCurrencies = await _currencyRepository.loadAllIndexedByCode();
    final CurrencyMap newCurrencies =
        CurrencyCollector.collectMissingCurrencies(
            existingCurrencies, fetchedCurrencies);
    await _currencyRepository.saveLastUpdateDateToNow();
    if (newCurrencies.isEmpty) {
      return;
    }

    CurrencyCollector.applyVisibility(newCurrencies);
    await _currencyRepository.saveAll(newCurrencies);

    final currencyCodes =
        newCurrencies.values.map((currency) => currency.code).toList();
    log("Added ${newCurrencies.length} new currencies: $currencyCodes");
  }
}
