import 'package:currency_calc/common/clock/clock.dart';
import 'package:currency_calc/common/clock/date_time_clock.dart';
import 'package:currency_calc/feature/conversion/internal/app/translate/conversion_validation_translator.dart';

class ConversionFeatureDic {
  ConversionFeatureDic() {
    _clock = DateTimeClock();
    _conversionValidationTranslator = ConversionValidationTranslator();
  }

  late final Clock _clock;
  late final ConversionValidationTranslator _conversionValidationTranslator;

  Clock get clock => _clock;

  ConversionValidationTranslator get conversionValidationTranslator =>
      _conversionValidationTranslator;
}
