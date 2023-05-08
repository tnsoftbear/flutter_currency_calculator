abstract class RateCacher {
  Future<double?> get(String sourceCurrency, String targetCurrency);
  Future<void> set(String sourceCurrency, String targetCurrency, double rate);
}
