import 'package:currency_calc/feature/conversion/internal/domain/validate/conversion_validation_result.dart';
import 'package:currency_calc/feature/conversion/internal/domain/validate/conversion_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversionValidator', () {
    const CURRENCY_CODES = [
      'USD',
      'EUR',
      'GBP',
    ];
    test('validate should return no errors for valid inputs', () {
      final result = ConversionValidator.validate(
          sourceCurrencyCode: CURRENCY_CODES[0],
          targetCurrencyCode: CURRENCY_CODES[1],
          amount: '100.00',
          visibleSourceCurrencyCodes: CURRENCY_CODES,
          visibleTargetCurrencyCodes: CURRENCY_CODES);
      expect(result.errors.length, 0);
    });

    test(
        'validate should return an error when source currency is invalid and others are valid',
        () {
      final result = ConversionValidator.validate(
          sourceCurrencyCode: 'XYZ',
          targetCurrencyCode: CURRENCY_CODES[1],
          amount: '100.00',
          visibleSourceCurrencyCodes: CURRENCY_CODES,
          visibleTargetCurrencyCodes: CURRENCY_CODES);
      expect(result.errors.length, 1);
      expect(result.errors[0],
          ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID);
    });

    test(
        'validate should return an error when target currency is invalid and others are valid',
        () {
      final result = ConversionValidator.validate(
          sourceCurrencyCode: CURRENCY_CODES[0],
          targetCurrencyCode: 'XYZ',
          amount: '100.00',
          visibleSourceCurrencyCodes: CURRENCY_CODES,
          visibleTargetCurrencyCodes: CURRENCY_CODES);
      expect(result.errors.length, 1);
      expect(result.errors[0],
          ConversionValidationResult.ERR_TARGET_CURRENCY_INVALID);
    });

    test(
        'validate should return an error when source and target currencies are same and others are valid',
        () {
      final result = ConversionValidator.validate(
          sourceCurrencyCode: CURRENCY_CODES[0],
          targetCurrencyCode: CURRENCY_CODES[0],
          amount: '100.00',
          visibleSourceCurrencyCodes: CURRENCY_CODES,
          visibleTargetCurrencyCodes: CURRENCY_CODES);
      expect(result.errors.length, 1);
      expect(result.errors[0],
          ConversionValidationResult.ERR_SOURCE_AND_TARGET_CURRENCY_SAME);
    });

    test('validate should return an error when amount is not numeric', () {
      final result = ConversionValidator.validate(
          sourceCurrencyCode: CURRENCY_CODES[0],
          targetCurrencyCode: CURRENCY_CODES[1],
          amount: 'not a number',
          visibleSourceCurrencyCodes: CURRENCY_CODES,
          visibleTargetCurrencyCodes: CURRENCY_CODES);
      expect(result.errors.length, 1);
      expect(result.errors[0],
          ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_NUMERIC);
    });

    test('validate should return an error when amount is not positive', () {
      final result = ConversionValidator.validate(
          sourceCurrencyCode: CURRENCY_CODES[0],
          targetCurrencyCode: CURRENCY_CODES[1],
          amount: '0.00',
          visibleSourceCurrencyCodes: CURRENCY_CODES,
          visibleTargetCurrencyCodes: CURRENCY_CODES);
      expect(result.errors.length, 1);
      expect(result.errors[0],
          ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_POSITIVE);
    });

    test('validate should return errors because all inputs are wrong', () {
      final result = ConversionValidator.validate(
          sourceCurrencyCode: 'XXX',
          targetCurrencyCode: 'XXX',
          amount: 'XXX',
          visibleSourceCurrencyCodes: CURRENCY_CODES,
          visibleTargetCurrencyCodes: CURRENCY_CODES);
      expect(result.errors.length, 4);
      expect(
          result.errors,
          equals([
            ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID,
            ConversionValidationResult.ERR_TARGET_CURRENCY_INVALID,
            ConversionValidationResult.ERR_SOURCE_AND_TARGET_CURRENCY_SAME,
            ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_NUMERIC
          ]));
    });
  });
}
