import 'package:currency_calc/feature/conversion/internal/app/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/rate_cached_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/constant/rate_fetching_constant.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/cache/rate_hive_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/load/fixer_io/fixer_io_rate_fetcher.dart';

class RateFetcherFactory {
  static RateFetcher create(ConversionConfig config) {
    RateFetcher? fetcher;
    if (config.currencyConversionRateFetcherType ==
        RateFetchingConstant.FT_FIXER_IO) {
      fetcher = FixerIoRateFetcher(
          url: config.fixerIoApiBaseUrl, apiKey: config.fixerIoApiKey);
    } else if (config.currencyConversionRateFetcherType ==
        RateFetchingConstant.FT_FAWAZ_AHMED) {
      fetcher = FawazAhmedExchangeRateFetcher(url: config.fawazAhmedApiBaseUrl);
    }

    if (fetcher == null) {
      throw Exception('Invalid currency rate fetcher type');
    }

    final cacher =
        RateHiveCacher(config.currencyConversionRateCacheExpiryInSeconds);
    return RateCachedFetcher(fetcher, cacher);
  }
}
