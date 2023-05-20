import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Currency', () {
    test('Equality', () {
      final currency1 = Currency('USD', 'US Dollar', true, false);
      final currency2 = Currency('USD', 'US Dollar', true, false);
      final currency3 = Currency('EUR', 'Euro', true, false);

      expect(currency1, equals(currency2));
      expect(currency1, isNot(equals(currency3)));
    });

    test('HashCode', () {
      final currency1 = Currency('USD', 'US Dollar', true, false);
      final currency2 = Currency('USD', 'US Dollar', true, false);
      final currency3 = Currency('EUR', 'Euro', true, false);

      expect(currency1.hashCode, equals(currency2.hashCode));
      expect(currency1.hashCode, isNot(equals(currency3.hashCode)));
    });

    test('CopyWith', () {
      final currency = Currency('USD', 'US Dollar', true, false);
      final copiedCurrency = currency.copyWith(
          name: 'United States Dollar', isVisibleForSource: false);

      expect(copiedCurrency.code, equals('USD'));
      expect(copiedCurrency.name, equals('United States Dollar'));
      expect(copiedCurrency.isVisibleForSource, isFalse);
      expect(copiedCurrency.isVisibleForTarget,
          equals(currency.isVisibleForTarget));
    });
  });
}
