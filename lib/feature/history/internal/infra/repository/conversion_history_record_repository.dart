import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConversionHistoryRecordRepository {
  static const BOX_NAME = 'CurrencyConversionHistoryRecord';

  Box<ConversionHistoryRecord>? box;

  Future<ConversionHistoryRecordRepository> init() async {
    if (box == null || box!.isOpen == false) {
      box = await Hive.openBox<ConversionHistoryRecord>(BOX_NAME);
    }
    return this;
  }

  Future<List<ConversionHistoryRecord>> loadAll() async {
    await init();
    return box!.values.toList();
  }

  Future<int> countAll() async {
    await init();
    return box!.length;
  }

  Future<void> save(ConversionHistoryRecord record) async {
    await init();
    await box!.add(record);
    await box!.close();
  }

  Future<void> deleteByIndex(int index) async {
    await init();
    await box!.deleteAt(index);
    await box!.close();
  }
}
