import 'package:currency_calc/feature/conversion/domain/constant/currency_constant.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/app/manage/setting_manager.dart';
import 'package:flutter/cupertino.dart';

class SettingModel with ChangeNotifier {
  String _languageCode = "";
  String _fontFamily = "";
  String _themeType = "";
  String _selectedSourceCurrencyCode = "";
  String _selectedTargetCurrencyCode = "";
  List<String> _visibleSourceCurrencyCodes = [];
  List<String> _visibleTargetCurrencyCodes = [];

  String get languageCode => _languageCode;

  String get fontFamily => _fontFamily;

  String get themeType => _themeType;

  String get selectedSourceCurrencyCode => _selectedSourceCurrencyCode;

  String get selectedTargetCurrencyCode => _selectedTargetCurrencyCode;

  List<String> get visibleSourceCurrencyCodes => _visibleSourceCurrencyCodes;

  List<String> get visibleTargetCurrencyCodes => _visibleTargetCurrencyCodes;

  Future<SettingModel> init() async {
    _languageCode = await SettingManager.detectLanguageCode();
    _fontFamily = await SettingManager.detectFontFamily();
    _themeType = await SettingManager.detectThemeType();
    _selectedSourceCurrencyCode = await SettingManager.detectSelectedSourceCurrencyCode();
    _selectedTargetCurrencyCode = await SettingManager.detectSelectedTargetCurrencyCode();
    _visibleSourceCurrencyCodes =
        await SettingManager.detectVisibleSourceCurrencyCodes();
    _visibleTargetCurrencyCodes =
        await SettingManager.detectVisibleTargetCurrencyCodes();
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
    _selectedSourceCurrencyCode =
        currencyCode ?? CurrencyConstant.SOURCE_CURRENCY_CODE_DEFAULT;
    SettingManager.saveDefaultSourceCurrencyCode(_selectedSourceCurrencyCode);
    notifyListeners();
  }

  void setTargetCurrencyCode(String? currencyCode) {
    _selectedTargetCurrencyCode =
        currencyCode ?? CurrencyConstant.TARGET_CURRENCY_CODE_DEFAULT;
    SettingManager.saveDefaultTargetCurrencyCode(_selectedTargetCurrencyCode);
    notifyListeners();
  }

  void setVisibleSourceCurrencyCodes(List<String>? currencyCodes) {
    _visibleSourceCurrencyCodes = currencyCodes ?? CurrencyConstant.CURRENCY_CODES;
    SettingManager.saveVisibleSourceCurrencyCodes(_visibleSourceCurrencyCodes);
    notifyListeners();
  }

  void setVisibleTargetCurrencyCodes(List<String>? currencyCodes) {
    _visibleTargetCurrencyCodes = currencyCodes ?? CurrencyConstant.CURRENCY_CODES;
    SettingManager.saveVisibleTargetCurrencyCodes(_visibleTargetCurrencyCodes);
    notifyListeners();
  }
}
