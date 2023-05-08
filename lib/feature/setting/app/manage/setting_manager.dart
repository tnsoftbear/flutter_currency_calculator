import 'package:currency_calc/feature/conversion/domain/constant/currency_constant.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/infra/repository/setting_repository.dart';
import 'package:flutter/material.dart';

class SettingManager {
  CurrencyFeatureFacade _currencyFeatureFacade;

  SettingManager(this._currencyFeatureFacade);

  Future<String> detectLanguageCode() async {
    return await SettingRepository.loadString("languageCode") ??
        AppearanceConstant.LC_DEFAULT;
  }

  Future<Locale> detectLocale() async {
    final languageCode = await detectLanguageCode();
    final locale = Locale(languageCode);
    return locale;
  }

  Future<void> saveLanguageCode(String languageCode) async {
    await SettingRepository.saveString("languageCode", languageCode);
  }

  Future<String> detectFontFamily() async {
    return await SettingRepository.loadString("fontFamily") ??
        AppearanceConstant.FF_DEFAULT;
  }

  Future<void> saveFontFamily(String fontFamily) async {
    await SettingRepository.saveString("fontFamily", fontFamily);
  }

  Future<String> detectThemeType() async {
    return await SettingRepository.loadString("themeType") ??
        AppearanceConstant.THEME_DEFAULT;
  }

  Future<void> saveThemeType(String themeType) async {
    await SettingRepository.saveString("themeType", themeType);
  }

  Future<String> detectSelectedSourceCurrencyCode() async {
    final currencyCode =
        await SettingRepository.loadString("selectedSourceCurrencyCode") ??
            CurrencyConstant.SOURCE_CURRENCY_CODE_DEFAULT;
    final currencyCodes = await CurrencyRepository().loadVisibleSourceCurrencyCodes();
    if (currencyCodes.isNotEmpty && !currencyCodes.contains(currencyCode)) {
      return currencyCodes.first;
    }
    return currencyCode;
  }

  Future<void> saveDefaultSourceCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString("selectedSourceCurrencyCode", currencyCode);
  }

  Future<String> detectSelectedTargetCurrencyCode() async {
    final currencyCode =
        await SettingRepository.loadString("selectedTargetCurrencyCode") ??
            CurrencyConstant.TARGET_CURRENCY_CODE_DEFAULT;
    final currencyCodes = await CurrencyRepository().loadVisibleTargetCurrencyCodes();
    if (currencyCodes.isNotEmpty && !currencyCodes.contains(currencyCode)) {
      return currencyCodes.first;
    }
    return currencyCode;
  }

  Future<void> saveDefaultTargetCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString("selectedTargetCurrencyCode", currencyCode);
  }

  Future<List<String>> detectVisibleSourceCurrencyCodes() async {
    final currencyCodes =
        await SettingRepository.loadVisibleSourceCurrencyCodes();
    if (currencyCodes == null || currencyCodes.isEmpty) {
      return await _currencyFeatureFacade.loadVisibleSourceCurrencyCodes();
    }
    return currencyCodes;
  }

  Future<void> saveVisibleSourceCurrencyCodes(
      List<String> currencyCodes) async {
    await SettingRepository.saveVisibleSourceCurrencyCodes(currencyCodes);
  }

  Future<List<String>> detectVisibleTargetCurrencyCodes() async {
    final currencyCodes =
        await SettingRepository.loadVisibleTargetCurrencyCodes();
    if (currencyCodes == null || currencyCodes.isEmpty) {
      return await _currencyFeatureFacade.loadVisibleTargetCurrencyCodes();
    }
    return currencyCodes;
  }

  Future<void> saveVisibleTargetCurrencyCodes(
      List<String> currencyCodes) async {
    await SettingRepository.saveVisibleTargetCurrencyCodes(currencyCodes);
  }
}
