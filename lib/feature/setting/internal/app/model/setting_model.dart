import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model_manager.dart';
import 'package:flutter/cupertino.dart';

class SettingModel with ChangeNotifier {
  static const SOURCE_CURRENCY_CODE_DEFAULT = 'USD';
  static const TARGET_CURRENCY_CODE_DEFAULT = 'EUR';

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

  SettingModelManager settingModelManager;

  SettingModel(this.settingModelManager);

  Future<SettingModel> init() async {
    _languageCode = await settingModelManager.detectLanguageCode();
    _fontFamily = await settingModelManager.detectFontFamily();
    _themeType = await settingModelManager.detectThemeType();
    _selectedSourceCurrencyCode =
        await settingModelManager.detectSelectedSourceCurrencyCode();
    _selectedTargetCurrencyCode = await settingModelManager
        .detectSelectedTargetCurrencyCode(_selectedSourceCurrencyCode);
    _visibleSourceCurrencyCodes =
        await settingModelManager.detectVisibleSourceCurrencyCodes();
    _visibleTargetCurrencyCodes =
        await settingModelManager.detectVisibleTargetCurrencyCodes();
    return this;
  }

  void setLanguageCode(String? languageCode) {
    _languageCode = languageCode ?? AppearanceConstant.LC_DEFAULT;
    settingModelManager.saveLanguageCode(_languageCode);
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
    settingModelManager.saveFontFamily(_fontFamily);
    notifyListeners();
  }

  void setThemeType(String? themeType) {
    _themeType = themeType ?? AppearanceConstant.THEME_DEFAULT;
    settingModelManager.saveThemeType(_themeType);
    notifyListeners();
  }

  void setSourceCurrencyCode(String? currencyCode) {
    _selectedSourceCurrencyCode = currencyCode ?? SOURCE_CURRENCY_CODE_DEFAULT;
    settingModelManager
        .saveDefaultSourceCurrencyCode(_selectedSourceCurrencyCode);
    notifyListeners();
  }

  void setTargetCurrencyCode(String? currencyCode) {
    _selectedTargetCurrencyCode = currencyCode ?? TARGET_CURRENCY_CODE_DEFAULT;
    settingModelManager
        .saveDefaultTargetCurrencyCode(_selectedTargetCurrencyCode);
    notifyListeners();
  }

  void setVisibleSourceCurrencyCodes(List<String> currencyCodes) {
    _visibleSourceCurrencyCodes = currencyCodes;
    settingModelManager
        .saveVisibleSourceCurrencyCodes(_visibleSourceCurrencyCodes);
    notifyListeners();
  }

  void setVisibleTargetCurrencyCodes(List<String> currencyCodes) {
    _visibleTargetCurrencyCodes = currencyCodes;
    settingModelManager
        .saveVisibleTargetCurrencyCodes(_visibleTargetCurrencyCodes);
    notifyListeners();
  }
}
