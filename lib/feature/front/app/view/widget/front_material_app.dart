import 'package:currency_calc/feature/about/app/view/screen/about_screen.dart';
import 'package:currency_calc/feature/conversion/app/history/view/screen/all_history_screen.dart';
import 'package:currency_calc/feature/conversion/app/rate/view/screen/calculator_screen.dart';
import 'package:currency_calc/feature/front/app/constant/route_constant.dart';
import 'package:currency_calc/feature/front/app/view/theme/theme_builder.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/app/manage/setting_manager.dart';
import 'package:currency_calc/feature/setting/app/view/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';

class FrontMaterialApp extends StatefulWidget {
  const FrontMaterialApp({Key? key}) : super(key: key);

  State<FrontMaterialApp> createState() => _FrontMaterialAppState();

  static void assignLocale(BuildContext context, Locale newLocale) async {
    _FrontMaterialAppState state =
        context.findAncestorStateOfType<_FrontMaterialAppState>()!;
    state.setLocale(newLocale);

    SettingManager.saveLanguageCode(newLocale.languageCode);
  }

  static void assignFontFamily(
      BuildContext context, String? newFontFamily) async {
    if (newFontFamily == null) {
      return;
    }

    _FrontMaterialAppState state =
        context.findAncestorStateOfType<_FrontMaterialAppState>()!;
    state.setFontFamily(newFontFamily);

    SettingManager.saveFontFamily(newFontFamily);
  }

  static String getFontFamily(BuildContext context) {
    _FrontMaterialAppState state =
        context.findAncestorStateOfType<_FrontMaterialAppState>()!;
    return state._fontFamily;
  }

  static void assignThemeType(BuildContext context, String? themeType) async {
    if (themeType == null) {
      return;
    }

    _FrontMaterialAppState state =
        context.findAncestorStateOfType<_FrontMaterialAppState>()!;
    state.setThemeType(themeType);

    SettingManager.saveThemeType(themeType);
  }

  static String getThemeType(BuildContext context) {
    _FrontMaterialAppState state =
        context.findAncestorStateOfType<_FrontMaterialAppState>()!;
    return state._themeType;
  }
}

class _FrontMaterialAppState extends State<FrontMaterialApp> {
  Locale? _locale;
  String _fontFamily = AppearanceConstant.FF_DEFAULT;
  String _themeType = AppearanceConstant.THEME_DEFAULT;

  @override
  void initState() {
    SettingManager.detectLocale().then((locale) => _locale = locale);
    SettingManager.detectFontFamily()
        .then((fontFamily) => _fontFamily = fontFamily);
    SettingManager.detectThemeType()
        .then((themeType) => _themeType = themeType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: ThemeBuilder.buildTheme(_themeType, _fontFamily),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: CalculatorScreen(),
      initialRoute: RouteConstant.currencyConversionRoute,
      routes: {
        RouteConstant.aboutRoute: (context) => AboutScreen(),
        RouteConstant.currencyConversionAllHistoryRoute: (context) =>
            AllHistoryScreen(),
        RouteConstant.currencyConversionRoute: (context) => CalculatorScreen(),
        RouteConstant.settingRoute: (context) => SettingScreen(),
      },
    );
  }

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  void setFontFamily(String newFontFamily) {
    setState(() {
      _fontFamily = newFontFamily;
    });
  }

  void setThemeType(String themeType) {
    setState(() {
      _themeType = themeType;
    });
  }
}
