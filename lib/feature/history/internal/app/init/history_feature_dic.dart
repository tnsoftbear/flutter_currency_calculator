import 'package:clock/clock.dart';
import 'package:currency_calc/feature/history/internal/infra/repository/conversion_history_record_repository.dart';

final class HistoryFeatureDic {
  HistoryFeatureDic() {
    _conversionHistoryRecordRepository = ConversionHistoryRecordRepository();
  }

  late final ConversionHistoryRecordRepository
      _conversionHistoryRecordRepository;

  Clock get clock => Clock();

  ConversionHistoryRecordRepository get conversionHistoryRecordRepository =>
      _conversionHistoryRecordRepository;
}
