import 'package:currency_calc/core/network/http/exception/could_not_fetch_any_http_response.dart';
import 'package:currency_calc/core/network/http/exception/could_not_fetch_success_http_response.dart';
import 'package:currency_calc/core/network/http/impl/dio_http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dio_http_client_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  group('get', () {
    const requestUrl = 'https://example.com/';
    const reasonPhrase = 'Reason phrase';
    const errorStatusCode = 404;

    test('returns string data if the http call completes successfully',
        () async {
      // Arrange
      final clientMock = MockDio();
      when(clientMock.get<String>(requestUrl, options: anyNamed('options')))
          .thenAnswer((_) async => Response(
              data: '{response}',
              statusCode: 200,
              requestOptions: RequestOptions(path: requestUrl)));
      final sut = DioHttpClient(clientMock);
      // Act
      final actual = await sut.get<String>(requestUrl);
      // Assert
      expect(actual, isA<String>());
      expect(actual, '{response}');
    });

    test(
        'throws an exception if the http call completes with an error response',
        () {
      // Arrange
      final clientMock = MockDio();
      when(clientMock.get(requestUrl, options: anyNamed('options'))).thenAnswer(
          (_) async => Response(
              data: 'error body',
              statusCode: errorStatusCode,
              statusMessage: reasonPhrase,
              requestOptions: RequestOptions(path: requestUrl)));
      final sut = DioHttpClient(clientMock);
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
      final clientMock = MockDio();
      when(clientMock.get<String>(requestUrl, options: anyNamed('options')))
          .thenThrow(DioError(
              requestOptions: RequestOptions(path: requestUrl),
              message: reasonPhrase));
      final sut = DioHttpClient(clientMock);
      // Act, Assert
      expect(
          sut.get(requestUrl),
          throwsA(predicate((e) =>
              e is CouldNotFetchAnyHttpResponse &&
              e.reasonPhrase == reasonPhrase)));

      // Alternatives:
      // expect(sut.get(requestUrl), throwsA(isA<CouldNotFetchAnyHttpResponse>()));
      // await expectLater(
      //     () => sut.get(requestUrl),
      //     throwsA(predicate((e) =>
      //         e is CouldNotFetchAnyHttpResponse &&
      //         e.reasonPhrase == reasonPhrase)));
    });
  });
}
