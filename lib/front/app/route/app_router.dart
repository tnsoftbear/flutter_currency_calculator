import 'package:currency_calc/feature/about/public/about_feature_facade.dart';
import 'package:currency_calc/feature/conversion/public/conversion_feature_facade.dart';
import 'package:currency_calc/feature/history/public/history_feature_facade.dart';
import 'package:currency_calc/feature/setting/public/setting_feature_facade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final class AppRouter {
  static String R_ABOUT = "/about";
  static String R_CALCULATE = "/calculate";
  static String R_HISTORY = "/history";
  static String R_SETTING = "/settings";
  static String R_DEFAULT = R_CALCULATE;

  static Map<String, WidgetBuilder> init() {
    return {
      R_ABOUT: (context) =>
          context.read<AboutFeatureFacade>().createAboutScreen(),
      R_CALCULATE: (context) =>
          context.read<ConversionFeatureFacade>().createCalculatorScreen(),
      R_HISTORY: (context) =>
          context.read<HistoryFeatureFacade>().createAllHistoryScreen(),
      R_SETTING: (context) =>
          context.read<SettingFeatureFacade>().createSettingScreen(),
    };
  }
}
