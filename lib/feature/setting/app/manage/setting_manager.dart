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

  static Future<String> detectSelectedSourceCurrencyCode() async {
    final currencyCode =
        await SettingRepository.loadString("selectedSourceCurrencyCode") ??
            CurrencyConstant.SOURCE_CURRENCY_CODE_DEFAULT;
    final currencyCodes = await detectVisibleSourceCurrencyCodes();
    if (!currencyCodes.contains(currencyCode)) {
      return currencyCodes.first;
    }
    return currencyCode;
  }

  static Future<void> saveDefaultSourceCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString("selectedSourceCurrencyCode", currencyCode);
  }

  static Future<String> detectSelectedTargetCurrencyCode() async {
    final currencyCode =
        await SettingRepository.loadString("selectedTargetCurrencyCode") ??
            CurrencyConstant.TARGET_CURRENCY_CODE_DEFAULT;
    final currencyCodes = await detectVisibleTargetCurrencyCodes();
    if (!currencyCodes.contains(currencyCode)) {
      return currencyCodes.first;
    }
    return currencyCode;
  }

  static Future<void> saveDefaultTargetCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString("selectedTargetCurrencyCode", currencyCode);
  }

  static Future<List<String>> detectVisibleSourceCurrencyCodes() async {
    final currencyCodes =
        await SettingRepository.loadVisibleSourceCurrencyCodes();
    if (currencyCodes == null || currencyCodes.isEmpty) {
      return CurrencyConstant.CURRENCY_CODES;
    }
    return currencyCodes;
  }

  static Future<void> saveVisibleSourceCurrencyCodes(
      List<String> currencyCodes) async {
    await SettingRepository.saveVisibleSourceCurrencyCodes(currencyCodes);
  }

  static Future<List<String>> detectVisibleTargetCurrencyCodes() async {
    final currencyCodes =
        await SettingRepository.loadVisibleTargetCurrencyCodes();
    if (currencyCodes == null || currencyCodes.isEmpty) {
      return CurrencyConstant.CURRENCY_CODES;
    }
    return currencyCodes;
  }

  static Future<void> saveVisibleTargetCurrencyCodes(
      List<String> currencyCodes) async {
    await SettingRepository.saveVisibleTargetCurrencyCodes(currencyCodes);
  }
}
