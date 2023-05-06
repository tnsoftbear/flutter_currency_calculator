import 'dart:convert';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:http/http.dart' as http;

class FawazAhmedAvailableCurrencyFetcher {
  final String url = "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json";
  //FawazAhmedAvailableCurrencyFetcher({required this.url});

  Future<Map<String, Currency>> fetchAvailableCurrencies() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final fetchedCurrencies = json.decode(response.body);
      print(fetchedCurrencies);
      final Map<String, Currency> resultCurrencies = {};
      for (var key in fetchedCurrencies.keys) {
        var name = fetchedCurrencies[key]!;
        final code = key.toUpperCase();
        resultCurrencies[code] = Currency(code, name);
      }
      return resultCurrencies;
    } else {
      throw Exception('Failed to load available currencies');
    }
  }
}