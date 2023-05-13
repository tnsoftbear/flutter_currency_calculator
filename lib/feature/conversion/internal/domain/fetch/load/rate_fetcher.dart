abstract class RateFetcher {
  Future<double> fetchExchangeRate(
      String sourceCurrencyCode, String targetCurrencyCode);
}
