import 'package:currency_calc/feature/about/public/about_feature_facade.dart';
import 'package:currency_calc/feature/history/internal/ui/screen/all_history_screen.dart';
import 'package:currency_calc/feature/conversion/internal/ui/screen/calculator_screen.dart';
import 'package:currency_calc/feature/setting/internal/ui/screen/setting_screen.dart';
import 'package:currency_calc/feature/setting/public/setting_feature_facade.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static String R_ABOUT = "/about";
  static String R_CALCULATE = "/calculate";
  static String R_HISTORY = "/history";
  static String R_SETTING = "/settings";
  static String R_DEFAULT = R_CALCULATE;

  static Map<String, WidgetBuilder> init() {
    return {
      R_ABOUT: (context) => context.read<AboutFeatureFacade>().createAboutScreen(),
      R_CALCULATE: (context) => const CalculatorScreen(),
      R_HISTORY: (context) => const AllHistoryScreen(),
      R_SETTING: (context) => context.read<SettingFeatureFacade>().createSettingScreen(),
    };
  }
}