import 'package:currency_calc/core/network/http/exception/could_not_fetch_any_http_response.dart';
import 'package:currency_calc/core/network/http/exception/could_not_fetch_success_http_response.dart';
import 'package:currency_calc/core/network/http/impl/http_http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_http_client_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  group('HttpHttpClient', () {
    const requestUrl = 'https://example.com/';
    const queryParamsMap = {'key1': 'val1', 'key2': 'val2'};
    const queryParamsString = '?key1=val1&key2=val2';
    const reasonPhrase = 'Reason phrase';
    const errorStatusCode = 404;

    test('returns string data if the http call completes successfully',
        () async {
      // Arrange
      final clientMock = MockClient();
      final Uri uri = Uri.parse(requestUrl + queryParamsString);
      when(clientMock.get(uri, headers: null))
          .thenAnswer((_) async => http.Response('{response}', 200));
      final sut = HttpHttpClient(clientMock);
      // Act
      final actual =
          await sut.get<String>(requestUrl, queryParams: queryParamsMap);
      // Assert
      expect(actual, isA<String>());
      expect(actual, '{response}');
      verify(clientMock.get(uri)).called(1);
    });

    test(
        'throws an exception if the http call completes with an error response',
        () {
      // Arrange
      final clientMock = MockClient();
      when(clientMock.get(Uri.parse(requestUrl), headers: null)).thenAnswer(
          (_) async => http.Response('body', errorStatusCode,
              reasonPhrase: reasonPhrase));
      final sut = HttpHttpClient(clientMock);
      // Act, Assert
      expect(
          () => sut.get(requestUrl),
          throwsA(predicate((e) =>
              e is CouldNotFetchSuccessHttpResponse &&
              e.reasonPhrase == reasonPhrase &&
              e.statusCode == errorStatusCode)));
    });

    test('throws an exception if the http call completes with exception',
        () async {
      // Arrange
      final clientMock = MockClient();
      when(clientMock.get(Uri.parse(requestUrl), headers: null))
          .thenThrow(Exception(reasonPhrase));
      final sut = HttpHttpClient(clientMock);
      // Act, Assert
      expect(
          () => sut.get(requestUrl),
          throwsA(predicate((e) =>
              e is CouldNotFetchAnyHttpResponse &&
              e.reasonPhrase == "Exception: $reasonPhrase")));

      // Alternatives:
      // expect(sut.get(requestUrl), throwsA(isA<CouldNotFetchAnyHttpResponse>()));
      // await expectLater(
      //     () => sut.get(requestUrl),
      //     throwsA(predicate((e) =>
      //         e is CouldNotFetchAnyHttpResponse &&
      //         e.reasonPhrase == "Exception: $reasonPhrase")));
    });
  });
}
