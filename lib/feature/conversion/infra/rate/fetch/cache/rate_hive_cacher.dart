import 'package:currency_calc/feature/conversion/domain/rate/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/domain/rate/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/conversion/infra/rate/repository/exchange_rate_record_repository.dart';

class RateHiveCacher extends RateCacher {
  int ttl = 0;

  RateHiveCacher(this.ttl);

  Future<double?> get(String from, String to) async {
    final key = _makeKey(from, to);
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

  Future<void> set(String from, String to, double rate) async {
    final key = _makeKey(from, to);
    final record = ExchangeRateRecord(
      sourceCurrency: from,
      targetCurrency: to,
      exchangeRate: rate,
      createdAt: DateTime.now(),
    );
    final repo = ExchangeRateRecordRepository();
    await repo.init();
    await repo.saveByKey(key, record);
  }

  String _makeKey(String from, String to) {
    return from + to;
  }
}
