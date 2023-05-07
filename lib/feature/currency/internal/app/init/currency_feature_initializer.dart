import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrencyFeatureInitializer {
  CurrencyFeatureInitializer() {
    init();
  }

  static void init() {
    Hive.registerAdapter(CurrencyAdapter());
  }
}