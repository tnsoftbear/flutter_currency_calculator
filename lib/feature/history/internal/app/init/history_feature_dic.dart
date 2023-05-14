import 'package:currency_calc/core/clock/clock.dart';
import 'package:currency_calc/core/clock/date_time_clock.dart';
import 'package:currency_calc/feature/history/internal/infra/repository/conversion_history_record_repository.dart';

class HistoryFeatureDic {
  HistoryFeatureDic() {
    _clock = DateTimeClock();
    _conversionHistoryRecordRepository = ConversionHistoryRecordRepository();
  }

  late final Clock _clock;
  late final ConversionHistoryRecordRepository
      _conversionHistoryRecordRepository;

  Clock get clock => _clock;

  ConversionHistoryRecordRepository get conversionHistoryRecordRepository =>
      _conversionHistoryRecordRepository;
}
