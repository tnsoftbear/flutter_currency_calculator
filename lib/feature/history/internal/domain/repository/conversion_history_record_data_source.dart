import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';

abstract interface class ConversionHistoryRecordDataSource {
  Future<int> countAll();

  Future<List<ConversionHistoryRecord>> loadAll();

  Future<void> save(ConversionHistoryRecord record);

  Future<void> deleteByIndex(int index);
}
