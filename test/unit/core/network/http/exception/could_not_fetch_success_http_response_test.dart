import 'package:currency_calc/core/network/http/exception/could_not_fetch_success_http_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CouldNotFetchSuccessHttpResponse', () {
    final testData = [
      {
        'exception': CouldNotFetchSuccessHttpResponse(
          message: 'Custom message',
          reasonPhrase: 'Not Found',
          statusCode: 404,
        ),
        'expectedString': 'Custom message - Not Found (404)',
      },
      {
        'exception': CouldNotFetchSuccessHttpResponse(
          statusCode: 400,
        ),
        'expectedString':
            CouldNotFetchSuccessHttpResponse.messageDefault + ' (400)',
      }
    ];

    for (var data in testData) {
      test('toString returns the expected string representation', () {
        final exception = data['exception'];
        expect(exception.toString(), equals(data['expectedString']));
      });
    }
  });
}
