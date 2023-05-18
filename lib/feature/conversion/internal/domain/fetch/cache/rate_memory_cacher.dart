import 'package:clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';

/**
 * Alternative implementation of RateCacher interface using memory.
 */
final class RateMemoryCacher implements RateCacher {
  RateMemoryCacher(int this._ttl, Clock this._clock);

  int _ttl = 0;
  Clock _clock;
  static Map<String, ExchangeRateRecord> _cache = {};

  Future<double?> get(String sourceCurrencyCode, String targetCurrencyCode) {
    final key = _makeKey(sourceCurrencyCode, targetCurrencyCode);
    if (_cache.containsKey(key)) {
      final record = _cache[key];
      if (record != null) {
        DateTime expiredAt = record.createdAt.add(Duration(seconds: _ttl));
        if (_clock.now().toUtc().isBefore(expiredAt)) {
          return Future.value(record.exchangeRate);
        }
      }

      _cache.remove(key);
      return Future.value(null);
    }

    return Future.value(null);
  }

  Future<void> set(
      String sourceCurrency, String targetCurrency, double rate) async {
    final key = _makeKey(sourceCurrency, targetCurrency);
    final record = ExchangeRateRecord(
      sourceCurrencyCode: sourceCurrency,
      targetCurrencyCode: targetCurrency,
      exchangeRate: rate,
      createdAt: _clock.now().toUtc(),
    );
    _cache[key] = record;
  }

  String _makeKey(String sourceCurrencyCode, String targetCurrencyCode) {
    return sourceCurrencyCode + "_" + targetCurrencyCode;
  }
}
