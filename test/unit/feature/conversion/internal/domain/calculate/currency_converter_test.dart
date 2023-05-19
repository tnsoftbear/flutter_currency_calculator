import 'package:currency_calc/feature/conversion/internal/domain/calculate/currency_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyConverter.convert() happy paths', () {
    final testData = [
      {
        'amount': 100.0,
        'rate': 1.2,
        'expectedResult': 120.0,
        'description': 'Conversion with positive amount and rate'
      },
      {
        'amount': 0.015,
        'rate': 0.02,
        'expectedResult': 0.0003,
        'description': 'Conversion with positive amount and rate'
      },
      {
        'amount': 0.0,
        'rate': 1.5,
        'expectedResult': 0.0,
        'description': 'Conversion with zero amount and positive rate'
      },
    ];

    for (var data in testData) {
      test('- ${data['description']} for amount ${data['amount']} and rate ${data['rate']}',
            () {
          // Arrange
          final amount = data['amount'] as double;
          final rate = data['rate'] as double;
          final expectedResult = data['expectedResult'] as double;

          // Act
          final result = CurrencyConverter.convert(amount, rate);

          // Assert
          expect(result, expectedResult);
        },
      );
    }
  });

  group('CurrencyConverter.convert() fail cases', ()
  {
    final testData = [
      {
        'amount': -100.0,
        'rate': 1.2,
        'description': 'Exception is thrown because of negative amount'
      },
      {
        'amount': 0.015,
        'rate': -0.02,
        'description': 'Exception is thrown because of negative rate'
      },
    ];

    for (var data in testData) {
      test('- ${data['description']} for amount ${data['amount']} and rate ${data['rate']}', () {
        // Arrange
        final amount = data['amount'] as double;
        final rate = data['rate'] as double;

        // Act
        final fn = () => CurrencyConverter.convert(amount, rate);

        // Assert
        expect(fn, throwsAssertionError);
      });
    }
  });
}
