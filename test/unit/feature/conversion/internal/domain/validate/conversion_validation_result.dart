import 'package:currency_calc/feature/conversion/internal/domain/validate/conversion_validation_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversionValidationResult', () {
    test('addError() should add the error to the errors list', () {
      final result = ConversionValidationResult();
      result.addError(ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID);
      expect(result.errors,
          [ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID]);
    });

    test('isSuccess() should return true if there are no errors', () {
      final result = ConversionValidationResult();
      expect(result.isSuccess(), isTrue);
    });

    test('isSuccess() should return false if there are errors', () {
      final result = ConversionValidationResult();
      result.addError(ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID);
      expect(result.isSuccess(), isFalse);
    });

    test('errors should return the list of errors', () {
      final result = ConversionValidationResult();
      result.addError(ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID);
      result.addError(ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_NUMERIC);
      expect(result.errors, [
        ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID,
        ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_NUMERIC,
      ]);
    });
  });
}
