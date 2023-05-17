import 'package:currency_calc/feature/conversion/internal/infra/fetch/cache/caching_type.dart';
import 'package:currency_calc/feature/conversion/internal/infra/fetch/load/fetching_type.dart';

final class ConversionConfig {
  final int currencyConversionRateCacheExpiryInSeconds = 24 * 60 * 60; // 1 day
  final CachingType currencyConversionRateCacheType = CachingType.Hive;
  final FetchingType currencyConversionRateFetcherType =
      FetchingType.fawazAhmed;

  final String fixerIoApiBaseUrl = 'https://api.apilayer.com/fixer/convert';
  final String fixerIoApiKey = '1yUWc2Kb2Bzr13w7hryFnkKBCxGV38Ia';

  final String fawazAhmedApiBaseUrl =
      'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest';
}
