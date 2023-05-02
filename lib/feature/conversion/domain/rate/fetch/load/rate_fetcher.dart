abstract class RateFetcher {
  Future<double> fetchExchangeRate(
      String sourceCurrency, String targetCurrency);
}
