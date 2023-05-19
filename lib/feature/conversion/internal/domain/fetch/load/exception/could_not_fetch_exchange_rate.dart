final class CouldNotFetchExchangeRate implements Exception {
  CouldNotFetchExchangeRate(
      {String this.message = 'Could not fetch exchange rate',
      String? this.reason});

  final String message;
  final String? reason;

  @override
  String toString() {
    String result = message;
    if (reason != null && reason!.isNotEmpty) {
      result += ' - $reason';
    }
    return result;
  }
}
