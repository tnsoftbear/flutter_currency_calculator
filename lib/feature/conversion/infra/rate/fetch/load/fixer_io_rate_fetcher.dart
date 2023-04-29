import 'package:currency_calc/feature/conversion/domain/rate/fetch/load/rate_fetcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FixerIoRateFetcher extends RateFetcher {
  final String url;
  final String apiKey;

  FixerIoRateFetcher({required this.url, required this.apiKey});

  Future<double> fetchExchangeRate(String from, String to) async {
    final url = this.url + '?from=$from&to=$to&amount=1';
    final response =
        await http.get(Uri.parse(url), headers: {'apikey': this.apiKey});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == false) {
        throw Exception(data['error']['info']);
      }
      return data['info']['rate'];
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }
}
