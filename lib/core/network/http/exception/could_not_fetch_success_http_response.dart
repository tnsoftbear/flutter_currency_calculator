final class CouldNotFetchSuccessHttpResponse implements Exception {
  static const messageDefault = 'Could not fetch success http response';

  CouldNotFetchSuccessHttpResponse(
      {String this.message = messageDefault,
      String? this.reasonPhrase,
      int? this.statusCode});

  late final String message;
  late final String? reasonPhrase;
  late final int? statusCode;

  @override
  String toString() {
    String result = message;
    if (reasonPhrase != null && reasonPhrase!.isNotEmpty) {
      result += ' - $reasonPhrase';
    }
    if (statusCode != null) {
      result += ' ($statusCode)';
    }
    return result;
  }
}
