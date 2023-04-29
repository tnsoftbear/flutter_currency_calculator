import 'package:currency_calc/feature/conversion/domain/rate/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/domain/rate/fetch/load/rate_fetcher.dart';

class RateCachedFetcher implements RateFetcher {
  final RateFetcher _currencyRateFetcher;
  final RateCacher _currencyRateCacher;

  RateCachedFetcher(this._currencyRateFetcher, this._currencyRateCacher);

  @override
  Future<double> fetchExchangeRate(String from, String to) async {
    final cachedCurrencyRate = await _currencyRateCacher.get(from, to);
    if (cachedCurrencyRate != null) {
      return cachedCurrencyRate;
    }

    final currencyRate = await _currencyRateFetcher.fetchExchangeRate(from, to);
    await _currencyRateCacher.set(from, to, currencyRate);
    return currencyRate;
  }
}
