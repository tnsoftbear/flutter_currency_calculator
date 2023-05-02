import 'package:currency_calc/feature/conversion/domain/rate/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/domain/rate/model/exchange_rate_record.dart';

class RateMemoryCacher extends RateCacher {
  int ttl = 0;
  static Map<String, ExchangeRateRecord> _cache = {};

  RateMemoryCacher(this.ttl);

  Future<double?> get(String sourceCurrency, String targetCurrency) {
    final key = _makeKey(sourceCurrency, targetCurrency);
    if (_cache.containsKey(key)) {
      final record = _cache[key];
      if (record != null) {
        DateTime expiredAt = record.createdAt.add(Duration(seconds: ttl));
        if (DateTime.now().isBefore(expiredAt)) {
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
      createdAt: DateTime.now(),
    );
    _cache[key] = record;
  }

  String _makeKey(String sourceCurrency, String targetCurrency) {
    return sourceCurrency + targetCurrency;
  }
}
