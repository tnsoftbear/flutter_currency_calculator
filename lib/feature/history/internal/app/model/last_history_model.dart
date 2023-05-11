import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:currency_calc/feature/history/internal/infra/repository/conversion_history_record_repository.dart';
import 'package:flutter/foundation.dart';

class LastHistoryModel with ChangeNotifier {
  static const LAST_HISTORY_RECORD_COUNT = 5;

  final ConversionHistoryRecordRepository _repo;
  List<ConversionHistoryRecord> _records = [];

  LastHistoryModel(this._repo);

  List<ConversionHistoryRecord> get records => _records;

  /**
   * Load the last N history records from DB.
   * Arrange them in reverse order, so the last record will be the first in the list.
   */
  Future<List<ConversionHistoryRecord>> load() async {
    final totalCount = await _repo.countAll();
    final skipCount = totalCount > LAST_HISTORY_RECORD_COUNT
        ? totalCount - LAST_HISTORY_RECORD_COUNT
        : 0;
    final allRecords = await _repo.loadAll();
    _records = allRecords
        .skip(skipCount)
        .toList()
        .reversed
        .toList();
    return _records;
    //log("History records loaded inside notifier (${_historyRecords.length})");
  }

  Future<void> add(String sourceCurrencyCode, String targetCurrencyCode,
      double sourceAmount, double targetAmount, double rate) async {
    var historyRecord = ConversionHistoryRecord()
      ..sourceCurrency = sourceCurrencyCode
      ..targetCurrency = targetCurrencyCode
      ..sourceAmount = sourceAmount
      ..targetAmount = targetAmount
      ..rate = rate
      ..date = DateTime.now();
    await _repo.save(historyRecord);
    notifyListeners();
  }

  /**
   * Delete record from DB by the index value defined in rendered table.
   * It is different index in comparison with records in DB,
   * because we render only several last records in the table.
   */
  Future<void> deleteRecordByTableIndex(int tableIndex) async {
    final deleteIndex = await _detectActualIndex(tableIndex);
    await _repo.deleteByIndex(deleteIndex);
    notifyListeners();
  }

  /**
   * Detect actual index of record in DB by the index value defined in rendered table.
   */
  Future<int> _detectActualIndex(int tableIndex) async {
    return await _repo.countAll() - tableIndex - 1;
  }
}
