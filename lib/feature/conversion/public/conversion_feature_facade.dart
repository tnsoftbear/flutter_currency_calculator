import 'package:currency_calc/feature/conversion/internal/app/init/conversion_feature_dic.dart';
import 'package:currency_calc/feature/conversion/internal/app/init/conversion_feature_initializer.dart';
import 'package:currency_calc/feature/conversion/internal/ui/screen/calculator_screen.dart';

class ConversionFeatureFacade {
  ConversionFeatureFacade(ConversionFeatureDic this._dic) {
    ConversionFeatureInitializer();
  }

  late final ConversionFeatureDic _dic;

  CalculatorScreen createCalculatorScreen() {
    return CalculatorScreen(
        _dic.clock, _dic.conversionValidationTranslator, _dic.rateFetcher);
  }
}
