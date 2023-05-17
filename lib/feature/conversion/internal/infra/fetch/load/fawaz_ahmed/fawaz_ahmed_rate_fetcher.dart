import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_data.dart';

final class FawazAhmedExchangeRateFetcher implements RateFetcher {
  String _baseUrl;
  HttpClient _httpClient;

  FawazAhmedExchangeRateFetcher({required url, required HttpClient httpClient})
      : _baseUrl = url,
        _httpClient = httpClient;

  @override
  Future<double> fetchExchangeRate(
      String sourceCurrencyCode, String targetCurrencyCode) async {
    targetCurrencyCode = targetCurrencyCode.toLowerCase();
    sourceCurrencyCode = sourceCurrencyCode.toLowerCase();
    final url =
        _baseUrl + '/currencies/$sourceCurrencyCode/$targetCurrencyCode.json';
    String encodedJson;
    try {
      encodedJson = await _httpClient.get<String>(url);
    } on Exception catch (e) {
      throw Exception('Failed to load exchange rate - ' + e.toString());
    }

    final rateData =
        FawazAhmedRateData.fromJson(encodedJson, targetCurrencyCode);
    return rateData.rate;
  }
}
