import 'package:currency_calc/feature/conversion/domain/constant/currency_constant.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/infra/repository/setting_repository.dart';
import 'package:flutter/material.dart';

class SettingManager {
  static Future<String> detectLanguageCode() async {
    return await SettingRepository.loadString("languageCode") ??
        AppearanceConstant.LC_DEFAULT;
  }

  static Future<Locale> detectLocale() async {
    final languageCode = await detectLanguageCode();
    final locale = Locale(languageCode);
    return locale;
  }

  static Future<void> saveLanguageCode(String languageCode) async {
    await SettingRepository.saveString("languageCode", languageCode);
  }

  static Future<String> detectFontFamily() async {
    return await SettingRepository.loadString("fontFamily") ??
        AppearanceConstant.FF_DEFAULT;
  }

  static Future<void> saveFontFamily(String fontFamily) async {
    await SettingRepository.saveString("fontFamily", fontFamily);
  }

  static Future<String> detectThemeType() async {
    return await SettingRepository.loadString("themeType") ??
        AppearanceConstant.THEME_DEFAULT;
  }

  static Future<void> saveThemeType(String themeType) async {
    await SettingRepository.saveString("themeType", themeType);
  }

  static Future<String> detectSourceCurrencyCode() async {
    return await SettingRepository.loadString("sourceCurrencyCode") ??
        CurrencyConstant.SOURCE_CURRENCY_DEFAULT;
  }

  static Future<void> saveDefaultSourceCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString("sourceCurrencyCode", currencyCode);
  }

  static Future<String> detectTargetCurrencyCode() async {
    return await SettingRepository.loadString("defaultTargetCurrencyCode") ??
        CurrencyConstant.TARGET_CURRENCY_DEFAULT;
  }

  static Future<void> saveDefaultTargetCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString("defaultTargetCurrencyCode", currencyCode);
  }
}
