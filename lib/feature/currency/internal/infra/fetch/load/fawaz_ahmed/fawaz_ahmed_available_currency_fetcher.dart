import 'dart:convert';
import 'dart:developer' as dev;
import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';

final class FawazAhmedAvailableCurrencyFetcher implements CurrencyFetcher {
  String _baseUrl;
  HttpClient _httpClient;

  FawazAhmedAvailableCurrencyFetcher({required String url, required HttpClient httpClient})
      : _baseUrl = url,
        _httpClient = httpClient;

  @override
  Future<Map<String, Currency>> fetchAvailableCurrencies() async {
    String encodedJson;
    try {
      encodedJson = await _httpClient.get<String>(_baseUrl);
    } on Exception catch (e) {
      throw Exception('Failed to load available currencies - ' + e.toString());
    }

    print(await encodedJson);
    final fetchedCurrencies = json.decode(encodedJson);
    dev.log("Available currencies fetched from API. Count: ${fetchedCurrencies
        .length}");
    final CurrencyMap resultCurrencies = {};
    for (var key in fetchedCurrencies.keys) {
      Currency currency = Currency(key, fetchedCurrencies[key]!);
      resultCurrencies[currency.code] = currency;
    }
    return resultCurrencies;
  }
}

// int takeCount = 10;
// List<String> keys = resultCurrencies.keys.toList().sublist(0, takeCount); // список ключей для сохранения
// Map<String, Currency> result = Map.fromEntries(resultCurrencies.entries.where((entry) => keys.contains(entry.key)));
// return result;
