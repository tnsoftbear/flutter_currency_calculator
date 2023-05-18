import 'package:clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_repository.dart';

final class RateCacherImpl implements RateCacher {
  RateCacherImpl(int this._ttl, Clock this._clock,
      ExchangeRateRecordRepository this._exchangeRateRecordRepository);

  final int _ttl;
  final Clock _clock;
  final ExchangeRateRecordRepository _exchangeRateRecordRepository;

  Future<double?> get(
      String sourceCurrencyCode, String targetCurrencyCode) async {
    final key = _makeKey(sourceCurrencyCode, targetCurrencyCode);
    ExchangeRateRecord? record =
        await _exchangeRateRecordRepository.loadByKey(key);
    if (record != null) {
      DateTime expiredAt = record.createdAt.add(Duration(seconds: _ttl));
      if (_clock.now().toUtc().isBefore(expiredAt)) {
        return record.exchangeRate;
      }

      await _exchangeRateRecordRepository.deleteByKey(key);
      return null;
    }

    return null;
  }

  Future<void> set(final String sourceCurrencyCode,
      final String targetCurrencyCode, final double rate) async {
    final key = _makeKey(sourceCurrencyCode, targetCurrencyCode);
    final record = ExchangeRateRecord(
      sourceCurrencyCode: sourceCurrencyCode,
      targetCurrencyCode: targetCurrencyCode,
      exchangeRate: rate,
      createdAt: _clock.now().toUtc(),
    );
    await _exchangeRateRecordRepository.saveByKey(key, record);
  }

  String _makeKey(
      final String sourceCurrencyCode, final String targetCurrencyCode) {
    return sourceCurrencyCode + "_" + targetCurrencyCode;
  }
}
