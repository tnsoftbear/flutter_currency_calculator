import 'package:currency_calc/feature/conversion/internal/domain/validate/conversion_validation_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConversionValidationTranslator {
  ConversionValidationTranslator();

  String translateConcatenatedErrorMessage(
      {required BuildContext context,
      required ConversionValidationResult validationResult,
      String separator = "\n"}) {
    final List<String> errorMessages = _translateErrorMessages(
        context: context, errors: validationResult.errors);
    return errorMessages.join(separator);
  }

  List<String> _translateErrorMessages(
      {required BuildContext context, required List<int> errors}) {
    final tr = AppLocalizations.of(context);
    final Map<int, String> _translations = {
      ConversionValidationResult.ERR_SOURCE_CURRENCY_INVALID:
          tr.conversionValidationErrSourceCurrencyInvalid,
      ConversionValidationResult.ERR_TARGET_CURRENCY_INVALID:
          tr.conversionValidationErrTargetCurrencyInvalid,
      ConversionValidationResult.ERR_SOURCE_AND_TARGET_CURRENCY_SAME:
          tr.conversionValidationErrSourceAndTargetCurrencySame,
      ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_NUMERIC:
          tr.conversionValidationErrSourceAmountNotNumeric,
      ConversionValidationResult.ERR_SOURCE_AMOUNT_NOT_POSITIVE:
          tr.conversionValidationErrSourceAmountNotPositive
    };
    final List<String> errorMessages = [];
    errors.forEach((error) {
      errorMessages.add(_translations[error] ?? '');
    });
    return errorMessages;
  }
}
