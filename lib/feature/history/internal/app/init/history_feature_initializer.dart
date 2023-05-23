import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

final class HistoryFeatureInitializer {
  HistoryFeatureInitializer() {
    Hive.registerAdapter(ConversionHistoryRecordAdapter());
  }
}
