import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';

abstract class CurrencyFetcher {
  Future<Map<String, Currency>> fetchAvailableCurrencies();
}