import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_rate_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FawazAhmedRateData', () {
    test('fromJson() parses the JSON correctly', () {
      // Arrange
      final encodedJson =
          '{"date": "2023-05-18", "eur": { "usd": 1.2, "gbp": 0.9 }}';
      final sourceCurrency = "EUR";
      final targetCurrency = 'USD';
      // Act
      final rateData = FawazAhmedRateData.fromJson(
          encodedJson, sourceCurrency, targetCurrency);
      // Assert
      expect(rateData.date, '2023-05-18');
      expect(rateData.rate, 1.2);
    });

    test('fromJson() throws an exception if the JSON is invalid', () {
      // Arrange
      final encodedJson = 'invalid_json';
      final sourceCurrency = "eur";
      final targetCurrency = 'usd';
      // Act, Assert
      expect(
        () => FawazAhmedRateData.fromJson(
            encodedJson, sourceCurrency, targetCurrency),
        throwsException,
      );
    });

    test(
        'fromJson() throws an exception if the target currency is not found in the JSON',
        () {
      // Arrange
      final encodedJson = '{"date": "2023-05-18", "eur": { "gbp": 0.9 }}';
      final sourceCurrency = "eur";
      final targetCurrency = 'usd';
      // Act, Assert
      expect(
        () => FawazAhmedRateData.fromJson(
            encodedJson, sourceCurrency, targetCurrency),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
