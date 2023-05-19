import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/rate_cached_fetcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'rate_cached_fetcher_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RateFetcher>()])
@GenerateNiceMocks([MockSpec<RateCacher>()])
void main() {
  group('RateCachedFetcher', () {
    const sourceCurrencyCode = 'USD';
    const targetCurrencyCode = 'EUR';
    final rateFetcher = MockRateFetcher();
    final rateCacher = MockRateCacher();
    final sut = RateCachedFetcher(rateFetcher, rateCacher);

    test('fetchExchangeRate() returns the cached exchange rate if available',
        () async {
      // Arrange
      final cachedRate = 1.2;
      when(rateCacher.get(sourceCurrencyCode, targetCurrencyCode))
          .thenAnswer((_) async => cachedRate);
      // Act
      final exchangeRate =
          await sut.fetchExchangeRate(sourceCurrencyCode, targetCurrencyCode);
      // Assert
      expect(exchangeRate, cachedRate);
      verifyNever(rateFetcher.fetchExchangeRate(any, any));
      verifyNever(rateCacher.set(any, any, any));
    });

    test(
        'fetchExchangeRate() fetches the exchange rate and caches it if not available',
        () async {
      // Arrange
      final fetchedRate = 1.5;
      when(rateCacher.get(sourceCurrencyCode, targetCurrencyCode))
          .thenAnswer((_) async => null);
      when(rateFetcher.fetchExchangeRate(
              sourceCurrencyCode, targetCurrencyCode))
          .thenAnswer((_) async => fetchedRate);
      // Act
      final exchangeRate =
          await sut.fetchExchangeRate(sourceCurrencyCode, targetCurrencyCode);
      // Assert
      expect(exchangeRate, fetchedRate);
      verify(rateFetcher.fetchExchangeRate(
              sourceCurrencyCode, targetCurrencyCode))
          .called(1);
      verify(rateCacher.set(
              sourceCurrencyCode, targetCurrencyCode, fetchedRate))
          .called(1);
    });
  });
}
