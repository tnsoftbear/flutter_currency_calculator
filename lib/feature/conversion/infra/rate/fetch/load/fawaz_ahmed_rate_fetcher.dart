import 'package:currency_calc/feature/conversion/domain/rate/fetch/load/rate_fetcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FawazAhmedExchangeRateFetcher extends RateFetcher {
  final String url;

  FawazAhmedExchangeRateFetcher({required this.url});

  Future<double> fetchExchangeRate(String from, String to) async {
    to = to.toLowerCase();
    from = from.toLowerCase();
    final url = this.url + '/currencies/$from/$to.json';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data[to];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
