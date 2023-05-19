import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/exception/could_not_fetch_exchange_rate.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_fetcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_data.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fawaz_ahmed_rate_fetcher_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpClient>()])
void main() {
  group('FawazAhmedExchangeRateFetcher', () {
    final baseUrl = 'https://example.com';
    final httpClient = MockHttpClient();
    final fetcher = FawazAhmedExchangeRateFetcher(
      url: baseUrl,
      httpClient: httpClient,
    );

    test('fetchExchangeRate() returns the correct exchange rate', () async {
      // Arrange
      final sourceCurrencyCode = 'USD';
      final targetCurrencyCode = 'EUR';
      final url = '$baseUrl/currencies/usd/eur.json';
      final encodedJson = '{"date": "2023-05-18", "usd": 0.9, "eur": 1.1}';
      final rateData =
          FawazAhmedRateData.fromJson(encodedJson, targetCurrencyCode);
      when(httpClient.get(url)).thenAnswer((_) async => encodedJson);
      // Act
      final exchangeRate = await fetcher.fetchExchangeRate(
          sourceCurrencyCode, targetCurrencyCode);
      // Assert
      expect(exchangeRate, rateData.rate);
      verify(httpClient.get(url)).called(1);
    });

    test('fetchExchangeRate() throws an exception if the HTTP request fails',
        () async {
      // Arrange
      final errorMessage = 'Failed to fetch data';
      when(httpClient.get(any)).thenThrow(Exception(errorMessage));
      // Act, Assert
      expect(
        () => fetcher.fetchExchangeRate('XXX', 'YYY'),
        throwsA(predicate((e) => e is CouldNotFetchExchangeRate
            && e.reason == "Exception: $errorMessage"
        )),
      );
      verify(httpClient.get(any)).called(1);
    });
  });
}
