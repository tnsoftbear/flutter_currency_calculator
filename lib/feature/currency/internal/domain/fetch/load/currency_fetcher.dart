import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';

abstract interface class CurrencyFetcher {
  Future<Map<String, Currency>> fetchAvailableCurrencies();
}