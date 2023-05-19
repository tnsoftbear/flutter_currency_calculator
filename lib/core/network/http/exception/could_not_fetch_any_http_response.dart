class CouldNotFetchAnyHttpResponse implements Exception {
  CouldNotFetchAnyHttpResponse(
      {String this.message = 'Could not fetch any http response',
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
