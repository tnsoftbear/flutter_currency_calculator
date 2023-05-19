import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FawazAhmedRateData', () {
    test('fromJson() parses the JSON correctly', () {
      // Arrange
      final encodedJson = '{"date": "2023-05-18", "usd": 1.2, "eur": 0.9}';
      final targetCurrency = 'USD';
      // Act
      final rateData = FawazAhmedRateData.fromJson(encodedJson, targetCurrency);
      // Assert
      expect(rateData.date, '2023-05-18');
      expect(rateData.rate, 1.2);
    });

    test('fromJson() throws an exception if the JSON is invalid', () {
      // Arrange
      final encodedJson = 'invalid_json';
      final targetCurrency = 'usd';
      // Act, Assert
      expect(
            () => FawazAhmedRateData.fromJson(encodedJson, targetCurrency),
        throwsException,
      );
    });

    test('fromJson() throws an exception if the target currency is not found in the JSON', () {
      // Arrange
      final encodedJson = '{"date": "2023-05-18", "eur": 0.9}';
      final targetCurrency = 'usd';
      // Act, Assert
      expect(
            () => FawazAhmedRateData.fromJson(encodedJson, targetCurrency),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
