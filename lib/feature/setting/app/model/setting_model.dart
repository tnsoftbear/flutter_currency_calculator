import 'package:currency_calc/feature/conversion/domain/constant/currency_constant.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/app/manage/setting_manager.dart';
import 'package:flutter/cupertino.dart';

class SettingModel with ChangeNotifier {
  late String _languageCode;
  late String _fontFamily;
  late String _themeType;
  late String _selectedSourceCurrencyCode;
  late String _selectedTargetCurrencyCode;
  late List<String> _visibleSourceCurrencyCodes;
  late List<String> _visibleTargetCurrencyCodes;

  String get languageCode => _languageCode;

  String get fontFamily => _fontFamily;

  String get themeType => _themeType;

  String get selectedSourceCurrencyCode => _selectedSourceCurrencyCode;

  String get selectedTargetCurrencyCode => _selectedTargetCurrencyCode;

  List<String> get visibleSourceCurrencyCodes => _visibleSourceCurrencyCodes;

  List<String> get visibleTargetCurrencyCodes => _visibleTargetCurrencyCodes;

  SettingManager settingManager;

  SettingModel(this.settingManager);

  Future<SettingModel> init() async {
    _languageCode = await settingManager.detectLanguageCode();
    _fontFamily = await settingManager.detectFontFamily();
    _themeType = await settingManager.detectThemeType();
    // (!) Temporal coupling:
    // settingManager.detectVisibleSourceCurrencyCodes() must be called before settingManager.detectSelectedSourceCurrencyCode()
    // because selected currency code must be included in visible currency codes.
    _visibleSourceCurrencyCodes =
        await settingManager.detectVisibleSourceCurrencyCodes();
    _visibleTargetCurrencyCodes =
        await settingManager.detectVisibleTargetCurrencyCodes();
    _selectedSourceCurrencyCode =
        await settingManager.detectSelectedSourceCurrencyCode();
    _selectedTargetCurrencyCode =
        await settingManager.detectSelectedTargetCurrencyCode();
    return this;
  }

  void setLanguageCode(String? languageCode) {
    _languageCode = languageCode ?? AppearanceConstant.LC_DEFAULT;
    settingManager.saveLanguageCode(_languageCode);
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
    settingManager.saveFontFamily(_fontFamily);
    notifyListeners();
  }

  void setThemeType(String? themeType) {
    _themeType = themeType ?? AppearanceConstant.THEME_DEFAULT;
    settingManager.saveThemeType(_themeType);
    notifyListeners();
  }

  void setSourceCurrencyCode(String? currencyCode) {
    _selectedSourceCurrencyCode =
        currencyCode ?? CurrencyConstant.SOURCE_CURRENCY_CODE_DEFAULT;
    settingManager.saveDefaultSourceCurrencyCode(_selectedSourceCurrencyCode);
    notifyListeners();
  }

  void setTargetCurrencyCode(String? currencyCode) {
    _selectedTargetCurrencyCode =
        currencyCode ?? CurrencyConstant.TARGET_CURRENCY_CODE_DEFAULT;
    settingManager.saveDefaultTargetCurrencyCode(_selectedTargetCurrencyCode);
    notifyListeners();
  }

  void setVisibleSourceCurrencyCodes(List<String>? currencyCodes) {
    _visibleSourceCurrencyCodes =
        currencyCodes ?? CurrencyConstant.CURRENCY_CODES;
    settingManager.saveVisibleSourceCurrencyCodes(_visibleSourceCurrencyCodes);
    notifyListeners();
  }

  void setVisibleTargetCurrencyCodes(List<String>? currencyCodes) {
    _visibleTargetCurrencyCodes =
        currencyCodes ?? CurrencyConstant.CURRENCY_CODES;
    settingManager.saveVisibleTargetCurrencyCodes(_visibleTargetCurrencyCodes);
    notifyListeners();
  }
}
