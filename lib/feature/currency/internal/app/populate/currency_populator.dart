import 'dart:developer';

import 'package:clock/clock.dart';
import 'package:currency_calc/feature/currency/internal/domain/collect/currency_collector.dart';
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

final class CurrencyPopulator {
  CurrencyPopulator(
      this._clock, this._currencyFetcher, this._currencyRepository);

  static const int _populationIntervalInDays = 7;

  final Clock _clock;
  final CurrencyFetcher _currencyFetcher;
  final CurrencyRepository _currencyRepository;

  Future<void> populateIfNeeded() async {
    if (await _mustPopulate()) {
      await _populate();
    }
  }

  Future<bool> _mustPopulate() async {
    final lastUpdateDate = await _currencyRepository.loadLastUpdateDate();
    if (lastUpdateDate == null) {
      return true;
    }

    final differenceInSec =
        _clock.now().toUtc().difference(lastUpdateDate).inSeconds;
    return differenceInSec > _populationIntervalInDays * 24 * 60 * 60;
  }

  Future<void> _populate() async {
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
