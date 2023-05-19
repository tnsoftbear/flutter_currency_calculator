final class CurrencyConverter {
  static double convert(double amount, double rate) {
    assert(amount >= 0, 'Amount cannot be negative');
    assert(rate >= 0, 'Rate cannot be negative');
    return amount * rate;
  }
}
