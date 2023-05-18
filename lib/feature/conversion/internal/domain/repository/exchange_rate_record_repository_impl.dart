import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_data_source.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_repository.dart';

final class ExchangeRateRecordRepositoryImpl
    implements ExchangeRateRecordRepository {
  ExchangeRateRecordRepositoryImpl(this._exchangeRateRecordDataSource);

  ExchangeRateRecordDataSource _exchangeRateRecordDataSource;

  @override
  Future<ExchangeRateRecord?> loadByKey(String key) async {
    return _exchangeRateRecordDataSource.loadByKey(key);
  }

  @override
  Future<void> saveByKey(String key, ExchangeRateRecord record) async {
    return _exchangeRateRecordDataSource.saveByKey(key, record);
  }

  @override
  Future<void> deleteByKey(String key) async {
    return _exchangeRateRecordDataSource.deleteByKey(key);
  }
}
