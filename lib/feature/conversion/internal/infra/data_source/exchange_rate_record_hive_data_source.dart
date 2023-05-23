import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_data_source.dart';
import 'package:hive_flutter/hive_flutter.dart';

final class ExchangeRateRecordHiveDataSource
    implements ExchangeRateRecordDataSource {
  ExchangeRateRecordHiveDataSource();

  static const BOX_NAME = 'CurrencyConversionRateFetchRecord';

  Box<ExchangeRateRecord>? box;

  Future<ExchangeRateRecordHiveDataSource> _init() async {
    if (box == null || box!.isOpen == false) {
      box = await Hive.openBox<ExchangeRateRecord>(BOX_NAME);
    }
    return this;
  }

  @override
  Future<ExchangeRateRecord?> loadByKey(String key) async {
    await _init();
    return await box!.get(key);
  }

  @override
  Future<void> saveByKey(String key, ExchangeRateRecord record) async {
    await _init();
    await box!.put(key, record);
  }

  @override
  Future<void> deleteByKey(String key) async {
    await _init();
    await box!.delete(key);
  }
}
