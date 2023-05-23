import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/caching_type.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fetching_type.dart';

final class ConversionConfig {
  ConversionConfig(
      {int this.currencyConversionRateCacheExpiryInSeconds = 24 * 60 * 60,
      CachingType this.currencyConversionRateCacheType = CachingType.repository,
      FetchingType this.currencyConversionRateFetcherType =
          FetchingType.fawazAhmed,
      String this.fixerIoApiBaseUrl = 'https://api.apilayer.com/fixer/convert',
      String this.fixerIoApiKey = '1yUWc2Kb2Bzr13w7hryFnkKBCxGV38Ia',
      String this.fawazAhmedApiBaseUrl =
          'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest'}) {}

  late final int currencyConversionRateCacheExpiryInSeconds; // 1 day
  late final CachingType currencyConversionRateCacheType;
  late final FetchingType currencyConversionRateFetcherType;

  late final String fixerIoApiBaseUrl;
  late final String fixerIoApiKey;

  late final String fawazAhmedApiBaseUrl;
}
