import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:currency_calc/feature/setting/internal/domain/repository/setting_repository.dart';
import 'package:flutter/material.dart';

final class SettingModelManager {
  SettingModelManager(this._settingRepository, this._currencyFeatureFacade);

  SettingRepository _settingRepository;
  CurrencyFeatureFacade _currencyFeatureFacade;

  Future<String> detectLanguageCode() async {
    return await _settingRepository.loadString("languageCode") ??
        AppearanceConstant.LC_DEFAULT;
  }

  Future<Locale> detectLocale() async {
    final languageCode = await detectLanguageCode();
    final locale = Locale(languageCode);
    return locale;
  }

  Future<void> saveLanguageCode(String languageCode) async {
    await _settingRepository.saveString("languageCode", languageCode);
  }

  Future<String> detectFontFamily() async {
    return await _settingRepository.loadString("fontFamily") ??
        AppearanceConstant.FF_DEFAULT;
  }

  Future<void> saveFontFamily(String fontFamily) async {
    await _settingRepository.saveString("fontFamily", fontFamily);
  }

  Future<String> detectThemeType() async {
    return await _settingRepository.loadString("themeType") ??
        AppearanceConstant.THEME_DEFAULT;
  }

  Future<void> saveThemeType(String themeType) async {
    await _settingRepository.saveString("themeType", themeType);
  }

  Future<String> detectSelectedSourceCurrencyCode() async {
    final currencyCode =
        await _settingRepository.loadString("selectedSourceCurrencyCode") ??
            SettingModel.SOURCE_CURRENCY_CODE_DEFAULT;
    final sourceCurrencyCodes =
        await _currencyFeatureFacade.loadVisibleSourceCurrencyCodes();
    if (sourceCurrencyCodes.isNotEmpty &&
        !sourceCurrencyCodes.contains(currencyCode)) {
      return sourceCurrencyCodes.first;
    }
    return currencyCode;
  }

  Future<void> saveDefaultSourceCurrencyCode(String currencyCode) async {
    await _settingRepository.saveString(
        "selectedSourceCurrencyCode", currencyCode);
  }

  Future<String> detectSelectedTargetCurrencyCode(
      String sourceCurrencyCode) async {
    final currencyCode =
        await _settingRepository.loadString("selectedTargetCurrencyCode") ??
            SettingModel.TARGET_CURRENCY_CODE_DEFAULT;
    final targetCurrencyCodes =
        await _currencyFeatureFacade.loadVisibleTargetCurrencyCodes();
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
    await _settingRepository.saveString(
        "selectedTargetCurrencyCode", currencyCode);
  }

  Future<List<String>> detectVisibleSourceCurrencyCodes() async {
    final visibleSourceCurrencyCodes =
        await _settingRepository.loadVisibleSourceCurrencyCodes();
    if (visibleSourceCurrencyCodes == null ||
        visibleSourceCurrencyCodes.isEmpty) {
      return await _currencyFeatureFacade.loadVisibleSourceCurrencyCodes();
    }
    return visibleSourceCurrencyCodes;
  }

  Future<void> saveVisibleSourceCurrencyCodes(
      List<String> currencyCodes) async {
    await _settingRepository.saveVisibleSourceCurrencyCodes(currencyCodes);
  }

  Future<List<String>> detectVisibleTargetCurrencyCodes() async {
    final visibleTargetCurrencyCodes =
        await _settingRepository.loadVisibleTargetCurrencyCodes();
    if (visibleTargetCurrencyCodes == null ||
        visibleTargetCurrencyCodes.isEmpty) {
      return await _currencyFeatureFacade.loadVisibleTargetCurrencyCodes();
    }
    return visibleTargetCurrencyCodes;
  }

  Future<void> saveVisibleTargetCurrencyCodes(
      List<String> currencyCodes) async {
    await _settingRepository.saveVisibleTargetCurrencyCodes(currencyCodes);
  }
}
