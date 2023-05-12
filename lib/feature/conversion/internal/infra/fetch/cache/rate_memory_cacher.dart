import 'package:currency_calc/common/clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';

class RateMemoryCacher extends RateCacher {
  RateMemoryCacher(int this._ttl, Clock this._clock);

  int _ttl = 0;
  Clock _clock;
  static Map<String, ExchangeRateRecord> _cache = {};

  Future<double?> get(String sourceCurrency, String targetCurrency) {
    final key = _makeKey(sourceCurrency, targetCurrency);
    if (_cache.containsKey(key)) {
      final record = _cache[key];
      if (record != null) {
        DateTime expiredAt = record.createdAt.add(Duration(seconds: _ttl));
        if (_clock.getCurrentDateUtc().isBefore(expiredAt)) {
          return Future.value(record.exchangeRate);
        }
      }

      _cache.remove(key);
      return Future.value(null);
    }

    return Future.value(null);
  }

  Future<void> set(String sourceCurrency, String targetCurrency, double rate) async {
    final key = _makeKey(sourceCurrency, targetCurrency);
    final record = ExchangeRateRecord(
      sourceCurrency: sourceCurrency,
      targetCurrency: targetCurrency,
      exchangeRate: rate,
      createdAt: _clock.getCurrentDateUtc(),
    );
    _cache[key] = record;
  }

  String _makeKey(String sourceCurrency, String targetCurrency) {
    return sourceCurrency + targetCurrency;
  }
}
