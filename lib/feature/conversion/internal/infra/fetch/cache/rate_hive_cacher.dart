import 'package:currency_calc/common/clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/conversion/internal/infra/repository/exchange_rate_record_repository.dart';

class RateHiveCacher extends RateCacher {
  RateHiveCacher(int this._ttl, Clock this._clock,
      ExchangeRateRecordRepository this._exchangeRateRecordRepository);

  final int _ttl;
  final Clock _clock;
  final ExchangeRateRecordRepository _exchangeRateRecordRepository;

  Future<double?> get(String sourceCurrency, String targetCurrency) async {
    final key = _makeKey(sourceCurrency, targetCurrency);
    ExchangeRateRecord? record =
        await _exchangeRateRecordRepository.loadByKey(key);
    if (record != null) {
      DateTime expiredAt = record.createdAt.add(Duration(seconds: _ttl));
      if (_clock.getCurrentDateUtc().isBefore(expiredAt)) {
        return Future.value(record.exchangeRate);
      }

      await _exchangeRateRecordRepository.deleteByKey(key);
      return Future.value(null);
    }

    return Future.value(null);
  }

  Future<void> set(
      String sourceCurrency, String targetCurrency, double rate) async {
    final key = _makeKey(sourceCurrency, targetCurrency);
    final record = ExchangeRateRecord(
      sourceCurrency: sourceCurrency,
      targetCurrency: targetCurrency,
      exchangeRate: rate,
      createdAt: _clock.getCurrentDateUtc(),
    );
    await _exchangeRateRecordRepository.saveByKey(key, record);
  }

  String _makeKey(String sourceCurrency, String targetCurrency) {
    return sourceCurrency + targetCurrency;
  }
}
