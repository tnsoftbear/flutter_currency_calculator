import 'package:clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/caching_type.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/impl/rate_memory_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/impl/rate_repository_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fetching_type.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fixer_io/fixer_io_rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/rate_cached_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/rate_fetcher_factory.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_repository.dart';
import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'rate_fetcher_factory_test.mocks.dart';

@GenerateNiceMocks([MockSpec<HttpClient>()])
@GenerateNiceMocks([MockSpec<ExchangeRateRecordRepository>()])

void main() {
  group('RateFetcherFactory', () {
    test('create returns RateCachedFetcher with FixerIoRateFetcher and RateRepositoryCacher', () {
      final config = ConversionConfig(
        currencyConversionRateFetcherType: FetchingType.fixerIo,
        currencyConversionRateCacheType: CachingType.repository,
        fixerIoApiBaseUrl: 'https://api.fixer.io',
        fixerIoApiKey: 'your-api-key',
        currencyConversionRateCacheExpiryInSeconds: 3600,
      );
      final httpClient = MockHttpClient();
      final clock = Clock();
      final exchangeRateRecordRepository = MockExchangeRateRecordRepository();

      final factory = RateFetcherFactory(
        config,
        clock,
        exchangeRateRecordRepository,
        httpClient,
      );

      final rateFetcher = factory.create();
      expect(rateFetcher, isA<RateCachedFetcher>());
      expect(rateFetcher.apiClient, isA<FixerIoRateFetcher>());
      expect(rateFetcher.cacher, isA<RateRepositoryCacher>());
    });

    test('create returns RateCachedFetcher with FawazAhmedExchangeRateFetcher and RateMemoryCacher', () {
      final config = ConversionConfig(
        currencyConversionRateFetcherType: FetchingType.fawazAhmed,
        currencyConversionRateCacheType: CachingType.memory,
        fawazAhmedApiBaseUrl: 'https://api.fawazahmed.com',
        currencyConversionRateCacheExpiryInSeconds: 1800,
      );
      final httpClient = MockHttpClient();
      final clock = Clock();
      final exchangeRateRecordRepository = MockExchangeRateRecordRepository();

      final factory = RateFetcherFactory(
        config,
        clock,
        exchangeRateRecordRepository,
        httpClient,
      );

      final rateFetcher = factory.create();
      expect(rateFetcher, isA<RateCachedFetcher>());
      expect(rateFetcher.apiClient, isA<FawazAhmedExchangeRateFetcher>());
      expect(rateFetcher.cacher, isA<RateMemoryCacher>());
    });
  });
}
