import 'package:clock/clock.dart';
import 'package:currency_calc/core/network/http/http_client.dart';
import 'package:currency_calc/feature/conversion/internal/domain/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fixer_io/fixer_io_rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/rate_cached_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/caching_type.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fetching_type.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/impl/rate_repository_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/impl/rate_memory_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_repository.dart';

final class RateFetcherFactory {
  RateFetcherFactory(
      ConversionConfig this._config,
      Clock this._clock,
      ExchangeRateRecordRepository this._exchangeRateRecordRepository,
      HttpClient this._httpClient);

  final ConversionConfig _config;
  final ExchangeRateRecordRepository _exchangeRateRecordRepository;
  final Clock _clock;
  final HttpClient _httpClient;

  RateCachedFetcher create() {
    RateFetcher fetcher = switch (_config.currencyConversionRateFetcherType) {
      FetchingType.fixerIo => FixerIoRateFetcher(
          url: _config.fixerIoApiBaseUrl,
          apiKey: _config.fixerIoApiKey,
          httpClient: _httpClient),
      FetchingType.fawazAhmed => FawazAhmedExchangeRateFetcher(
          url: _config.fawazAhmedApiBaseUrl, httpClient: _httpClient),
    };

    RateCacher cacher = switch (_config.currencyConversionRateCacheType) {
      CachingType.repository => RateRepositoryCacher(
          _config.currencyConversionRateCacheExpiryInSeconds,
          _clock,
          _exchangeRateRecordRepository),
      CachingType.memory => RateMemoryCacher(
          _config.currencyConversionRateCacheExpiryInSeconds, _clock),
    };
    return RateCachedFetcher(fetcher, cacher);
  }
}
