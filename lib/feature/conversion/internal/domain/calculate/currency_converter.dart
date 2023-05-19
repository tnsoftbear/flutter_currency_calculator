final class CurrencyConverter {
  static double convert(double amount, double rate) {
    if (amount < 0) {
      throw ArgumentError('Amount cannot be negative');
    }
    if (rate < 0) {
      throw ArgumentError('Rate cannot be negative');
    }
    return amount * rate;
  }
}
