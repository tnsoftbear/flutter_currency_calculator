import 'package:clock/clock.dart';
import 'package:currency_calc/feature/history/internal/domain/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/feature/history/internal/domain/repository/conversion_history_record_repository_impl.dart';
import 'package:currency_calc/feature/history/internal/infra/repository/conversion_history_record_hive_data_source.dart';

final class HistoryFeatureDic {
  HistoryFeatureDic() {
    _conversionHistoryRecordRepository = ConversionHistoryRecordRepositoryImpl(
        ConversionHistoryRecordHiveDataSource());
  }

  late final ConversionHistoryRecordRepository
      _conversionHistoryRecordRepository;

  Clock get clock => Clock();

  ConversionHistoryRecordRepository get conversionHistoryRecordRepository =>
      _conversionHistoryRecordRepository;
}
