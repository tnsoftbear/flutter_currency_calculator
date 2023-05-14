import 'package:currency_calc/core/clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/app/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/rate_cached_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/constant/rate_fetching_constant.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/cache/rate_hive_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/load/fixer_io/fixer_io_rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/repository/exchange_rate_record_repository.dart';

class RateFetcherFactory {
  RateFetcherFactory(ConversionConfig this._config, Clock this._clock,
      ExchangeRateRecordRepository this._exchangeRateRecordRepository);

  final ConversionConfig _config;
  final ExchangeRateRecordRepository _exchangeRateRecordRepository;
  final Clock _clock;

  RateFetcher create() {
    RateFetcher? fetcher;
    if (_config.currencyConversionRateFetcherType ==
        RateFetchingConstant.FT_FIXER_IO) {
      fetcher = FixerIoRateFetcher(
          url: _config.fixerIoApiBaseUrl, apiKey: _config.fixerIoApiKey);
    } else if (_config.currencyConversionRateFetcherType ==
        RateFetchingConstant.FT_FAWAZ_AHMED) {
      fetcher =
          FawazAhmedExchangeRateFetcher(url: _config.fawazAhmedApiBaseUrl);
    }

    if (fetcher == null) {
      throw Exception('Invalid currency rate fetcher type');
    }

    final cacher = RateHiveCacher(
        _config.currencyConversionRateCacheExpiryInSeconds,
        _clock,
        _exchangeRateRecordRepository);
    return RateCachedFetcher(fetcher, cacher);
  }
}
