import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/exception/could_not_fetch_exchange_rate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CouldNotFetchExchangeRate', () {
    final testData = [
      {
        'exception': CouldNotFetchExchangeRate(
          message: 'Custom message',
          reason: 'Not Found',
        ),
        'expectedString': 'Custom message - Not Found',
      },
      {
        'exception': CouldNotFetchExchangeRate(),
        'expectedString': CouldNotFetchExchangeRate.messageDefault,
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
