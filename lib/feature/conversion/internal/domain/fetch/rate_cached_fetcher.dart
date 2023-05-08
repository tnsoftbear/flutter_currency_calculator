import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';

class RateCachedFetcher implements RateFetcher {
  final RateFetcher _currencyRateFetcher;
  final RateCacher _currencyRateCacher;

  RateCachedFetcher(this._currencyRateFetcher, this._currencyRateCacher);

  @override
  Future<double> fetchExchangeRate(
      String sourceCurrency, String targetCurrency) async {
    final cachedCurrencyRate =
        await _currencyRateCacher.get(sourceCurrency, targetCurrency);
    if (cachedCurrencyRate != null) {
      return cachedCurrencyRate;
    }

    final currencyRate = await _currencyRateFetcher.fetchExchangeRate(
        sourceCurrency, targetCurrency);
    await _currencyRateCacher.set(sourceCurrency, targetCurrency, currencyRate);
    return currencyRate;
  }
}
