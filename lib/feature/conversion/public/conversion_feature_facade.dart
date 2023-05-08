import 'package:currency_calc/feature/conversion/internal/app/init/conversion_feature_initializer.dart';
import 'package:currency_calc/feature/conversion/internal/ui/screen/calculator_screen.dart';

class ConversionFeatureFacade {
  ConversionFeatureFacade() {
    ConversionFeatureInitializer();
  }

  CalculatorScreen createCalculatorScreen() {
    return const CalculatorScreen();
  }
}
