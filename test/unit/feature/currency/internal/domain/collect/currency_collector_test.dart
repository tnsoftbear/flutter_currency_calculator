import 'package:currency_calc/feature/currency/internal/domain/collect/currency_collector.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyCollector', () {
    final eur = Currency('EUR', 'Euro');
    final usd = Currency('USD', 'US Dollar');
    final gbp = Currency('GBP', 'British Pound');
    final rub = Currency('RUB', 'Russian Ruble');

    test('collectMissingCurrencies() should collect missing currencies', () {
      // Arrange
      final existingCurrencies = {'EUR': eur, 'USD': usd};
      final fetchedCurrencies = {'EUR': eur, 'GBP': gbp, 'RUB': rub};
      // Act
      final result = CurrencyCollector.collectMissingCurrencies(
        existingCurrencies,
        fetchedCurrencies,
      );
      // Assert
      expect(result, {'GBP': gbp, 'RUB': rub});
    });

    test('applyVisibility() should apply visibility to currencies', () {
      final currencies = {
        'EUR': eur,
        'GBP': gbp,
        'RUB': rub,
        'USD': usd,
      };

      CurrencyCollector.applyVisibility(currencies);

      expect(currencies['EUR']!.isVisibleForSource, isTrue);
      expect(currencies['EUR']!.isVisibleForTarget, isTrue);

      expect(currencies['GBP']!.isVisibleForSource, isTrue);
      expect(currencies['GBP']!.isVisibleForTarget, isTrue);

      expect(currencies['RUB']!.isVisibleForSource, isTrue);
      expect(currencies['RUB']!.isVisibleForTarget, isTrue);

      expect(currencies['USD']!.isVisibleForSource, isTrue);
      expect(currencies['USD']!.isVisibleForTarget, isTrue);
    });
  });
}
