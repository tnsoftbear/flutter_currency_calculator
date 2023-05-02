import 'package:currency_calc/feature/conversion/domain/rate/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/infra/rate/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_data.dart';
import 'package:http/http.dart' as http;

class FawazAhmedExchangeRateFetcher extends RateFetcher {
  final String url;

  FawazAhmedExchangeRateFetcher({required this.url});

  Future<double> fetchExchangeRate(
      String sourceCurrency, String targetCurrency) async {
    targetCurrency = targetCurrency.toLowerCase();
    sourceCurrency = sourceCurrency.toLowerCase();
    final url = this.url + '/currencies/$sourceCurrency/$targetCurrency.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = FawazAhmedRateData.fromJson(response.body, targetCurrency);
      return data.rate;
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
