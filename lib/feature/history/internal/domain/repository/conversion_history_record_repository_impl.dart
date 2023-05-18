import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:currency_calc/feature/history/internal/domain/repository/conversion_history_record_data_source.dart';

import 'conversion_history_record_repository.dart';

final class ConversionHistoryRecordRepositoryImpl
    implements ConversionHistoryRecordRepository {
  ConversionHistoryRecordRepositoryImpl(
      this._conversionHistoryRecordDataSource);

  ConversionHistoryRecordDataSource _conversionHistoryRecordDataSource;

  @override
  Future<int> countAll() async {
    return _conversionHistoryRecordDataSource.countAll();
  }

  @override
  Future<List<ConversionHistoryRecord>> loadAll() async {
    return _conversionHistoryRecordDataSource.loadAll();
  }

  @override
  Future<void> save(ConversionHistoryRecord record) async {
    _conversionHistoryRecordDataSource.save(record);
  }

  @override
  Future<void> deleteByIndex(int index) async {
    _conversionHistoryRecordDataSource.deleteByIndex(index);
  }
}
