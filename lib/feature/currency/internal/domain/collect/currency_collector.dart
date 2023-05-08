import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/conversion/internal/domain/constant/currency_constant.dart';

class CurrencyCollector {
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
    currencies.forEach((currencyCode, currency) {
      if (CurrencyConstant.CURRENCY_CODES.contains(currencyCode)) {
        currency.isVisibleForSource = true;
        currency.isVisibleForTarget = true;
      }
    });
  }
}
