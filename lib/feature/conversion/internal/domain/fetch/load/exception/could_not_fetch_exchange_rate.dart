final class CouldNotFetchExchangeRate implements Exception {
  static const messageDefault = 'Could not fetch exchange rate';

  CouldNotFetchExchangeRate(
      {String this.message = messageDefault, String? this.reason});

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
