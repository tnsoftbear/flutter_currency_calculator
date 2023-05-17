import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

final class FixerIoRateFetcher implements RateFetcher {
  final String url;
  final String apiKey;

  FixerIoRateFetcher({required this.url, required this.apiKey});

  Future<double> fetchExchangeRate(
      String sourceCurrencyCode, String targetCurrencyCode) async {
    final url =
        this.url + '?from=$sourceCurrencyCode&to=$targetCurrencyCode&amount=1';
    final response = await Dio()
        .get(url, options: Options(headers: {'apikey': this.apiKey}));
    if (response.statusCode == 200) {
      final data = json.decode(response.data);
      if (data['success'] == false) {
        throw Exception(data['error']['info']);
      }
      return data['info']['rate'];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
