final class CouldNotFetchSuccessHttpResponse implements Exception {
  CouldNotFetchSuccessHttpResponse(
      {String this.message = 'Could not fetch success http response',
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
