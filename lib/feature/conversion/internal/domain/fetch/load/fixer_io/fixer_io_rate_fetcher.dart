import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'dart:convert';

final class FixerIoRateFetcher implements RateFetcher {
  final String _baseUrl;
  final String _apiKey;
  final HttpClient _httpClient;

  FixerIoRateFetcher({required url, required apiKey, required httpClient})
      : _baseUrl = url,
        _apiKey = apiKey,
        _httpClient = httpClient;

  @override
  Future<double> fetchExchangeRate(
      String sourceCurrencyCode, String targetCurrencyCode) async {
    final url = this._baseUrl;
    final queryParams = {
      'from': sourceCurrencyCode,
      'to': targetCurrencyCode,
      'amount': 1
    };
    String encodedJson;
    try {
      encodedJson = await _httpClient.get<String>(url,
          queryParams: queryParams, headers: {'apikey': _apiKey});
    } on Exception catch (e) {
      throw Exception('Failed to load exchange rate ' + e.toString());
    }

    final encodedMap = json.decode(encodedJson);
    if (encodedMap['success'] == false) {
      throw Exception(encodedMap['error']['info']);
    }
    return encodedMap['info']['rate'];
  }
}
