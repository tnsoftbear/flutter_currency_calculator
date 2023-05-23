import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/exception/could_not_fetch_exchange_rate.dart';
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_available_currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fawaz_ahmed_available_currency_fetcher_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpClient>()])
void main() {
  group('FawazAhmedAvailableCurrencyFetcher', () {
    test(
        'fetchAvailableCurrencies() should fetch and parse available currencies',
        () async {
      final url = 'https://example.com/currencies';
      final httpClient =
          MockHttpClient(); // Provide a mock or test implementation of HttpClient

      final sut = FawazAhmedAvailableCurrencyFetcher(
        url: url,
        httpClient: httpClient,
      );

      // Provide a mock implementation of the HTTP response
      final encodedJson =
          '{"USD": "US Dollar", "EUR": "Euro", "GBP": "British Pound"}';
      when(httpClient.get(url)).thenAnswer((_) async => encodedJson);

      final result = await sut.fetchAvailableCurrencies();

      expect(
          result,
          equals({
            'USD': Currency('USD', 'US Dollar'),
            'EUR': Currency('EUR', 'Euro'),
            'GBP': Currency('GBP', 'British Pound'),
          }));
    });

    test(
        'fetchAvailableCurrencies() should throw CouldNotFetchAvailableCurrencyList on exception',
        () async {
      final url = 'https://example.com/currencies';
      final httpClient =
          MockHttpClient(); // Provide a mock or test implementation of HttpClient
      const errorMessage = 'Failed to fetch currencies';

      final fetcher = FawazAhmedAvailableCurrencyFetcher(
        url: url,
        httpClient: httpClient,
      );

      // Provide a mock implementation of the HTTP response that throws an exception
      when(httpClient.get(any)).thenThrow(Exception(errorMessage));

      expect(
        () async => await fetcher.fetchAvailableCurrencies(),
        throwsA(isA<CouldNotFetchAvailableCurrencyList>()),
      );
    });
  });
}
