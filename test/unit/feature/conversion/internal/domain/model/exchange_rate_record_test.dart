import 'package:clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExchangeRateRecord', () {
    final sourceCurrencyCode = 'USD';
    final targetCurrencyCode = 'EUR';
    final exchangeRate = 1.2;
    final Clock clock = Clock.fixed(DateTime.now());
    final createdAt = clock.now();

    test('copyWith should create a new ExchangeRateRecord with updated values',
        () {
      // Arrange
      final originalRecord = ExchangeRateRecord(
        sourceCurrencyCode: sourceCurrencyCode,
        targetCurrencyCode: targetCurrencyCode,
        exchangeRate: exchangeRate,
        createdAt: createdAt,
      );
      final newSourceCurrencyCode = 'GBP';
      final newTargetCurrencyCode = 'CAD';
      final newExchangeRate = 1.5;
      final newCreatedAt = clock.now().subtract(Duration(days: 1));

      // Act
      final updatedRecord = originalRecord.copyWith(
        sourceCurrencyCode: newSourceCurrencyCode,
        targetCurrencyCode: newTargetCurrencyCode,
        exchangeRate: newExchangeRate,
        createdAt: newCreatedAt,
      );

      // Assert
      expect(updatedRecord.sourceCurrencyCode, equals(newSourceCurrencyCode));
      expect(updatedRecord.targetCurrencyCode, equals(newTargetCurrencyCode));
      expect(updatedRecord.exchangeRate, equals(newExchangeRate));
      expect(updatedRecord.createdAt, equals(newCreatedAt));
    });

    test('props should return the correct list of properties', () {
      // Arrange
      final record1 = ExchangeRateRecord(
        sourceCurrencyCode: sourceCurrencyCode,
        targetCurrencyCode: targetCurrencyCode,
        exchangeRate: exchangeRate,
        createdAt: createdAt,
      );
      // Act
      final props1 = record1.props;
      // Assert
      expect(
          props1,
          equals([
            sourceCurrencyCode,
            targetCurrencyCode,
            exchangeRate,
            createdAt
          ]));
    });
  });
}
