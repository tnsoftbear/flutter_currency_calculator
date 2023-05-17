abstract interface class RateCacher {
  Future<double?> get(String sourceCurrencyCode, String targetCurrencyCode);

  Future<void> set(
      String sourceCurrencyCode, String targetCurrencyCode, double rate);
}
