import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_data.dart';
import 'package:http/http.dart' as http;

class FawazAhmedExchangeRateFetcher extends RateFetcher {
  final String url;

  FawazAhmedExchangeRateFetcher({required this.url});

  Future<double> fetchExchangeRate(
      String sourceCurrencyCode, String targetCurrencyCode) async {
    targetCurrencyCode = targetCurrencyCode.toLowerCase();
    sourceCurrencyCode = sourceCurrencyCode.toLowerCase();
    final url =
        this.url + '/currencies/$sourceCurrencyCode/$targetCurrencyCode.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data =
          FawazAhmedRateData.fromJson(response.body, targetCurrencyCode);
      return data.rate;
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
