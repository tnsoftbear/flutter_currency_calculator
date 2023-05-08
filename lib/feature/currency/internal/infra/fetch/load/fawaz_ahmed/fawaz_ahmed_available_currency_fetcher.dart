import 'dart:convert';
import 'dart:developer' as dev;
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:http/http.dart' as http;

class FawazAhmedAvailableCurrencyFetcher implements CurrencyFetcher {
  final String url =
      "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json";

  //FawazAhmedAvailableCurrencyFetcher({required this.url});

  Future<Map<String, Currency>> fetchAvailableCurrencies() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final fetchedCurrencies = json.decode(response.body);
      dev.log("Available currencies fetched from API. Count: ${fetchedCurrencies.length}");
      final Map<String, Currency> resultCurrencies = {};
      for (var key in fetchedCurrencies.keys) {
        var name = fetchedCurrencies[key]!;
        final code = key.toUpperCase();
        resultCurrencies[code] = Currency(code, name, true, true);
      }

      int takeCount = 10;
      List<String> keys = resultCurrencies.keys.toList().sublist(0, takeCount); // список ключей для сохранения
      Map<String, Currency> result = Map.fromEntries(resultCurrencies.entries.where((entry) => keys.contains(entry.key)));

      return result;
    } else {
      throw Exception('Failed to load available currencies');
    }
  }
}
