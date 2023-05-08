import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/conversion/internal/domain/constant/currency_constant.dart';
import 'package:currency_calc/feature/setting/internal/infra/repository/setting_repository.dart';
import 'package:flutter/material.dart';

class SettingModelManager {
  CurrencyFeatureFacade _currencyFeatureFacade;

  SettingModelManager(this._currencyFeatureFacade);

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
    final sourceCurrencyCodes =
        await CurrencyRepository().loadVisibleSourceCurrencyCodes();
    if (sourceCurrencyCodes.isNotEmpty &&
        !sourceCurrencyCodes.contains(currencyCode)) {
      return sourceCurrencyCodes.first;
    }
    return currencyCode;
  }

  Future<void> saveDefaultSourceCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString(
        "selectedSourceCurrencyCode", currencyCode);
  }

  Future<String> detectSelectedTargetCurrencyCode(
      String sourceCurrencyCode) async {
    final currencyCode =
        await SettingRepository.loadString("selectedTargetCurrencyCode") ??
            CurrencyConstant.TARGET_CURRENCY_CODE_DEFAULT;
    final targetCurrencyCodes =
        await CurrencyRepository().loadVisibleTargetCurrencyCodes();
    if (targetCurrencyCodes.isNotEmpty &&
        !targetCurrencyCodes.contains(currencyCode)) {
      if (targetCurrencyCodes.first == sourceCurrencyCode &&
          targetCurrencyCodes.length > 1) {
        return targetCurrencyCodes[1];
      }
      return targetCurrencyCodes.first;
    }
    return currencyCode;
  }

  Future<void> saveDefaultTargetCurrencyCode(String currencyCode) async {
    await SettingRepository.saveString(
        "selectedTargetCurrencyCode", currencyCode);
  }

  Future<List<String>> detectVisibleSourceCurrencyCodes() async {
    final visibleSourceCurrencyCodes =
        await SettingRepository.loadVisibleSourceCurrencyCodes();
    if (visibleSourceCurrencyCodes == null ||
        visibleSourceCurrencyCodes.isEmpty) {
      return await _currencyFeatureFacade.loadVisibleSourceCurrencyCodes();
    }
    return visibleSourceCurrencyCodes;
  }

  Future<void> saveVisibleSourceCurrencyCodes(
      List<String> currencyCodes) async {
    await SettingRepository.saveVisibleSourceCurrencyCodes(currencyCodes);
  }

  Future<List<String>> detectVisibleTargetCurrencyCodes() async {
    final visibleTargetCurrencyCodes =
        await SettingRepository.loadVisibleTargetCurrencyCodes();
    if (visibleTargetCurrencyCodes == null ||
        visibleTargetCurrencyCodes.isEmpty) {
      return await _currencyFeatureFacade.loadVisibleTargetCurrencyCodes();
    }
    return visibleTargetCurrencyCodes;
  }

  Future<void> saveVisibleTargetCurrencyCodes(
      List<String> currencyCodes) async {
    await SettingRepository.saveVisibleTargetCurrencyCodes(currencyCodes);
  }
}