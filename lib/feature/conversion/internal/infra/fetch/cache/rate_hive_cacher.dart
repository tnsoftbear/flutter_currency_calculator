import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/conversion/internal/infra/repository/exchange_rate_record_repository.dart';

class RateHiveCacher extends RateCacher {
  int ttl = 0;

  RateHiveCacher(this.ttl);

  Future<double?> get(String sourceCurrency, String targetCurrency) async {
    final key = _makeKey(sourceCurrency, targetCurrency);
    final repo = ExchangeRateRecordRepository();
    await repo.init();
    ExchangeRateRecord? record = await repo.loadByKey(key);
    if (record != null) {
      DateTime expiredAt = record.createdAt.add(Duration(seconds: ttl));
      if (DateTime.now().isBefore(expiredAt)) {
        return Future.value(record.exchangeRate);
      }

      await repo.deleteByKey(key);
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
    final repo = ExchangeRateRecordRepository();
    await repo.init();
    await repo.saveByKey(key, record);
  }

  String _makeKey(String sourceCurrency, String targetCurrency) {
    return sourceCurrency + targetCurrency;
  }
}
