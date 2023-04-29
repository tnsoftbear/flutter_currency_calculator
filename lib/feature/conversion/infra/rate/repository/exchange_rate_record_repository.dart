import 'package:currency_calc/feature/conversion/domain/rate/model/exchange_rate_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExchangeRateRecordRepository {
  static const BOX_NAME = 'CurrencyConversionRateFetchRecord';

  Box<ExchangeRateRecord>? box;

  Future<ExchangeRateRecordRepository> init() async {
    box = await Hive.openBox<ExchangeRateRecord>(BOX_NAME);
    return this;
  }

  Future<ExchangeRateRecord?> loadByKey(String key) async {
    return await box!.get(key);
  }

  Future<void> saveByKey(String key, ExchangeRateRecord record) async {
    await box!.put(key, record);
    await box!.close();
  }

  Future<void> deleteByKey(String key) async {
    await box!.delete(key);
    await box!.close();
  }
}
