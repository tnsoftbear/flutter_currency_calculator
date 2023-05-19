import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/exception/could_not_fetch_exchange_rate.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_data.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';

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
      throw CouldNotFetchExchangeRate(reason: e.toString());
    }

    final rateData =
        FawazAhmedRateData.fromJson(encodedJson, targetCurrencyCode);
    return rateData.rate;
  }
}
