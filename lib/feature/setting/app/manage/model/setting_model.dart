import 'package:currency_calc/feature/conversion/domain/constant/currency_constant.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/app/manage/setting_manager.dart';
import 'package:flutter/cupertino.dart';

class SettingModel with ChangeNotifier {
  String _languageCode = "";
  String _fontFamily = "";
  String _themeType = "";
  String _sourceCurrencyCode = "";
  String _targetCurrencyCode = "";

  String get languageCode => _languageCode;

  String get fontFamily => _fontFamily;

  String get themeType => _themeType;

  String get sourceCurrencyCode => _sourceCurrencyCode;

  String get targetCurrencyCode => _targetCurrencyCode;

  Future<SettingModel> init() async {
    _languageCode = await SettingManager.detectLanguageCode();
    _fontFamily = await SettingManager.detectFontFamily();
    _themeType = await SettingManager.detectThemeType();
    _sourceCurrencyCode = await SettingManager.detectSourceCurrencyCode();
    _targetCurrencyCode = await SettingManager.detectTargetCurrencyCode();
    return this;
  }

  void setLanguageCode(String? languageCode) {
    _languageCode = languageCode ?? AppearanceConstant.LC_DEFAULT;
    SettingManager.saveLanguageCode(_languageCode);
    notifyListeners();
  }

  Locale detectLocale() {
    final countryCode =
        AppearanceConstant.CONFIG[_languageCode]!['countryCode'];
    final locale = Locale(_languageCode, countryCode);
    return locale;
  }

  void setFontFamily(String? fontFamily) {
    _fontFamily = fontFamily ?? AppearanceConstant.FF_DEFAULT;
    SettingManager.saveFontFamily(_fontFamily);
    notifyListeners();
  }

  void setThemeType(String? themeType) {
    _themeType = themeType ?? AppearanceConstant.THEME_DEFAULT;
    SettingManager.saveThemeType(_themeType);
    notifyListeners();
  }

  void setSourceCurrencyCode(String? currencyCode) {
    _sourceCurrencyCode =
        currencyCode ?? CurrencyConstant.SOURCE_CURRENCY_DEFAULT;
    SettingManager.saveDefaultSourceCurrencyCode(_sourceCurrencyCode);
    notifyListeners();
  }

  void setTargetCurrencyCode(String? currencyCode) {
    _targetCurrencyCode =
        currencyCode ?? CurrencyConstant.TARGET_CURRENCY_DEFAULT;
    SettingManager.saveDefaultTargetCurrencyCode(_targetCurrencyCode);
    notifyListeners();
  }
}
