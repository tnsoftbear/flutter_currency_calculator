import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/repository/conversion_history_record_data_source.dart';

final class ConversionHistoryRecordHiveDataSource
    implements ConversionHistoryRecordDataSource {
  ConversionHistoryRecordHiveDataSource();

  static const BOX_NAME = 'CurrencyConversionHistoryRecord';

  Box<ConversionHistoryRecord>? box;

  Future<ConversionHistoryRecordHiveDataSource> _init() async {
    if (box == null || box!.isOpen == false) {
      box = await Hive.openBox<ConversionHistoryRecord>(BOX_NAME);
    }
    return this;
  }

  @override
  Future<int> countAll() async {
    await _init();
    return box!.length;
  }

  @override
  Future<List<ConversionHistoryRecord>> loadAll() async {
    await _init();
    return box!.values.toList();
  }

  @override
  Future<void> save(ConversionHistoryRecord record) async {
    await _init();
    await box!.add(record);
  }

  @override
  Future<void> deleteByIndex(int index) async {
    await _init();
    await box!.deleteAt(index);
  }
}
