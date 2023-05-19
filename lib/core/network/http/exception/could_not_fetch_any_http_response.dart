final class CouldNotFetchAnyHttpResponse implements Exception {
  static const messageDefault = 'Could not fetch any http response';

  CouldNotFetchAnyHttpResponse(
      {String this.message = messageDefault,
      String this.reasonPhrase = ''});

  late final String message;
  late final String reasonPhrase;

  @override
  String toString() {
    String result = message;
    if (reasonPhrase.isNotEmpty) {
      result += ' - ' + reasonPhrase;
    }
    return result;
  }
}
