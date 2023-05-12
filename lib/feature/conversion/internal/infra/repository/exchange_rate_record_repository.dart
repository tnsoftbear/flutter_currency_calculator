import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExchangeRateRecordRepository {
  ExchangeRateRecordRepository();

  static const BOX_NAME = 'CurrencyConversionRateFetchRecord';

  Box<ExchangeRateRecord>? box;

  Future<ExchangeRateRecordRepository> init() async {
    if (box == null || box!.isOpen == false) {
      box = await Hive.openBox<ExchangeRateRecord>(BOX_NAME);
    }
    return this;
  }

  Future<ExchangeRateRecord?> loadByKey(String key) async {
    await init();
    return await box!.get(key);
  }

  Future<void> saveByKey(String key, ExchangeRateRecord record) async {
    await init();
    await box!.put(key, record);
    await box!.close();
  }

  Future<void> deleteByKey(String key) async {
    await init();
    await box!.delete(key);
    await box!.close();
  }
}
