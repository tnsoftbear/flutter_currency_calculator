import 'conversion_validation_result.dart';

class ConversionValidator {
  static ConversionValidationResult validate(
      {required String sourceCurrencyCode,
      required String targetCurrencyCode,
      required String amount,
      required List<String> visibleSourceCurrencyCodes,
      required List<String> visibleTargetCurrencyCodes}) {
    final result = ConversionValidationResult();

    if (!visibleSourceCurrencyCodes.contains(sourceCurrencyCode)) {
      result.addError(ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID);
    }

    if (!visibleTargetCurrencyCodes.contains(targetCurrencyCode)) {
      result.addError(ConversionValidationResult.ERR_TARGET_CURRENCY_INVALID);
    }

    if (sourceCurrencyCode == targetCurrencyCode) {
      result.addError(
          ConversionValidationResult.ERR_SOURCE_AND_TARGET_CURRENCY_SAME);
    }

    double? sourceAmount = double.tryParse(amount);
    if (sourceAmount == null) {
      result.addError(ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_NUMERIC);
    } else if (sourceAmount <= 0) {
      result
          .addError(ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_POSITIVE);
    }

    return result;
  }
}
