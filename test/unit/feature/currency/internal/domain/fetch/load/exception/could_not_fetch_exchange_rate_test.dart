import 'package:currency_calc/feature/currency/internal/domain/fetch/load/exception/could_not_fetch_exchange_rate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CouldNotFetchAvailableCurrencyList', () {
    test('toString should return the correct string representation', () {
      // Arrange
      final message = 'Could not fetch available currency list';
      final reason = 'Server error';
      final sut = CouldNotFetchAvailableCurrencyList(
        message: message,
        reason: reason,
      );
      // Act
      final result = sut.toString();
      // Assert
      expect(result, equals('$message - $reason'));
    });

    test(
        'toString should return the correct string representation when reason is null',
        () {
      // Arrange
      final message = 'Could not fetch available currency list';
      final sut = CouldNotFetchAvailableCurrencyList(
        message: message,
      );
      // Act
      final result = sut.toString();
      // Assert
      expect(result, equals(message));
    });
  });
}
