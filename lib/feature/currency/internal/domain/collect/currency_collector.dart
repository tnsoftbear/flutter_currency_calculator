import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';

class CurrencyCollector {
  static const VISIBLE_CURRENCY_CODES = ['EUR', 'GBP', 'RUB', 'USD'];

  static CurrencyMap collectMissingCurrencies(
      CurrencyMap existingCurrencies, CurrencyMap fetchedCurrencies) {
    final CurrencyMap resultCurrencies = {};
    fetchedCurrencies.forEach((currencyCode, currency) {
      if (!existingCurrencies.containsKey(currencyCode)) {
        resultCurrencies[currencyCode] = currency;
      }
    });
    return resultCurrencies;
  }

  static void applyVisibility(CurrencyMap currencies) {
    VISIBLE_CURRENCY_CODES.forEach((currencyCode) {
      if (currencies.containsKey(currencyCode)) {
        currencies[currencyCode] = currencies[currencyCode]!.copyWith(
            isVisibleForSource: true, isVisibleForTarget: true);
      }
    });
  }
}
