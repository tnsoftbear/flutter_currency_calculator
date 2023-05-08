import 'package:currency_calc/feature/conversion/internal/domain/calculate/currency_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('convert() should return the correct amount', () {
    // arrange
    final amount = 100.0;
    final rate = 0.89;

    // act
    final result = CurrencyConverter.convert(amount, rate);

    // assert
    expect(result, equals(89));
  });
}
