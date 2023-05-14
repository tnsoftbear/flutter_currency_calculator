import 'package:clock/clock.dart';
import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:currency_calc/feature/history/internal/infra/repository/conversion_history_record_repository.dart';
import 'package:flutter/foundation.dart';

class LastHistoryModel with ChangeNotifier {
  LastHistoryModel(this._clock, this._conversionHistoryRecordRepository,
      {this.lastHistoryRecordCount = 5});

  final Clock _clock;
  final ConversionHistoryRecordRepository _conversionHistoryRecordRepository;
  final int lastHistoryRecordCount;
  List<ConversionHistoryRecord> _records = [];

  List<ConversionHistoryRecord> get records => _records;

  /**
   * Load the last N history records from DB.
   * Arrange them in reverse order, so the last record will be the first in the list.
   */
  Future<List<ConversionHistoryRecord>> load() async {
    final totalCount = await _conversionHistoryRecordRepository.countAll();
    final skipCount = totalCount > lastHistoryRecordCount
        ? totalCount - lastHistoryRecordCount
        : 0;
    final allRecords = await _conversionHistoryRecordRepository.loadAll();
    _records = allRecords.skip(skipCount).toList().reversed.toList();
    return _records;
  }

  Future<void> add(String sourceCurrencyCode, double sourceAmount,
      String targetCurrencyCode, double targetAmount, double rate) async {
    var historyRecord = ConversionHistoryRecord(
        sourceCurrencyCode: sourceCurrencyCode,
        targetCurrencyCode: targetCurrencyCode,
        sourceAmount: sourceAmount,
        targetAmount: targetAmount,
        rate: rate,
        date: clock.now().toUtc());
    await _conversionHistoryRecordRepository.save(historyRecord);
    notifyListeners();
  }

  /**
   * Delete record from DB by the index value defined in rendered table.
   * It is different index in comparison with records in DB,
   * because we render only several last records in the table.
   */
  Future<void> deleteRecordByTableIndex(int tableIndex) async {
    final deleteIndex = await _detectActualIndex(tableIndex);
    await _conversionHistoryRecordRepository.deleteByIndex(deleteIndex);
    notifyListeners();
  }

  /**
   * Detect actual index of record in DB by the index value defined in rendered table.
   */
  Future<int> _detectActualIndex(int tableIndex) async {
    return await _conversionHistoryRecordRepository.countAll() - tableIndex - 1;
  }
}
