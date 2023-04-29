import 'package:currency_calc/feature/conversion/domain/constant/currency_constant.dart';

import 'conversion_validation_result.dart';

class ConversionValidator {
  static ConversionValidationResult validate(
      {required String sourceCurrency,
      required String targetCurrency,
      required String amount}) {
    final result = ConversionValidationResult();

    if (!CurrencyConstant.CURRENCIES.contains(sourceCurrency)) {
      result.addError(ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID);
    }

    if (!CurrencyConstant.CURRENCIES.contains(targetCurrency)) {
      result.addError(ConversionValidationResult.ERR_TARGET_CURRENCY_INVALID);
    }

    if (sourceCurrency == targetCurrency) {
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
