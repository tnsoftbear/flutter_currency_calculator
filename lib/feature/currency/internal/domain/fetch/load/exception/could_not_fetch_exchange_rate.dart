final class CouldNotFetchAvailableCurrencyList implements Exception {
  static const messageDefault = 'Could not fetch available currency list';

  CouldNotFetchAvailableCurrencyList(
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
