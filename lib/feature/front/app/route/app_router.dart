import 'package:currency_calc/feature/about/app/view/screen/about_screen.dart';
import 'package:currency_calc/feature/conversion/app/history/view/screen/all_history_screen.dart';
import 'package:currency_calc/feature/conversion/app/rate/view/screen/calculator_screen.dart';
import 'package:currency_calc/feature/setting/app/view/screen/setting_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static String R_ABOUT = "/about";
  static String R_CALCULATE = "/calculate";
  static String R_HISTORY = "/history";
  static String R_SETTING = "/settings";
  static String R_DEFAULT = R_CALCULATE;

  static Map<String, WidgetBuilder> init() {
    return {
      R_ABOUT: (context) => AboutScreen(),
      R_CALCULATE: (context) => CalculatorScreen(),
      R_HISTORY: (context) => AllHistoryScreen(),
      R_SETTING: (context) => SettingScreen(),
    };
  }
}