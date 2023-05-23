import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:hive_flutter/hive_flutter.dart';

final class ConversionFeatureInitializer {
  ConversionFeatureInitializer() {
    Hive.registerAdapter(ExchangeRateRecordAdapter());
  }
}
