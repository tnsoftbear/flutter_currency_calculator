import 'package:currency_calc/feature/conversion/internal/infra/constant/rate_fetching_constant.dart';

class ConversionConfig {
  final int currencyConversionRateCacheExpiryInSeconds = 24 * 60 * 60; // 1 day
  final int currencyConversionRateCacheType = RateFetchingConstant.CT_HIVE;
  final int currencyConversionRateFetcherType =
      RateFetchingConstant.FT_FAWAZ_AHMED;

  final String fixerIoApiBaseUrl = 'https://api.apilayer.com/fixer/convert';
  final String fixerIoApiKey = '1yUWc2Kb2Bzr13w7hryFnkKBCxGV38Ia';

  final String fawazAhmedApiBaseUrl =
      'https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest';
}
