import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';

abstract interface class ExchangeRateRecordRepository {
  Future<ExchangeRateRecord?> loadByKey(String key);

  Future<void> saveByKey(String key, ExchangeRateRecord record);

  Future<void> deleteByKey(String key);
}
