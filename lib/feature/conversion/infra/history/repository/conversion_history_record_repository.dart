import 'package:currency_calc/feature/conversion/domain/history/model/conversion_history_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ConversionHistoryRecordRepository {
  static const BOX_NAME = 'CurrencyConversionHistoryRecord';

  Box<ConversionHistoryRecord>? box;

  Future<ConversionHistoryRecordRepository> init() async {
    box = await Hive.openBox<ConversionHistoryRecord>(BOX_NAME);
    return this;
  }

  List<ConversionHistoryRecord> loadAll() {
    return box!.values.toList();
  }

  int countAll() {
    return box!.length;
  }

  Future<void> save(ConversionHistoryRecord record) async {
    await box!.add(record);
    await box!.close();
  }

  Future<void> deleteByIndex(int index) async {
    await box!.deleteAt(index);
    await box!.close();
  }
}
