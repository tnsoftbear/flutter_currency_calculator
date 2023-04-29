import 'package:currency_calc/feature/front/app/view/theme/additional_colors.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_header_bar.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;
    return Scaffold(
      appBar: FrontHeaderBar(
        titleText: AppLocalizations.of(context).settingTitle,
        isSettingMenu: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage(
                AppearanceConstant.BG_IMAGE_FOR_SETTING_SCREEN),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: additionalColors.linenTurbidColor,
              // instead of BorderRadius.circular(8.0), to make the const constructor call
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLocaleSetting(context),
                _buildFontFamilySetting(context),
                _buildThemeSetting(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onLocaleChange(BuildContext context, String? languageCode) {
    languageCode = languageCode ?? AppearanceConstant.LC_DEFAULT;
    final countryCode = AppearanceConstant.CONFIG[languageCode]!['countryCode'];
    final locale = Locale(languageCode, countryCode);
    FrontMaterialApp.assignLocale(context, locale);
  }

  _buildLocaleSetting(BuildContext context) {
    final tr = AppLocalizations.of(context);
    List<Map<String, String>> languages = [
      {
        'title': tr.settingLocaleEnLabel,
        'value': AppearanceConstant.LC_EN,
      },
      {
        'title': tr.settingLocaleRuLabel,
        'value': AppearanceConstant.LC_RU,
      },
    ];
    final List<Widget> localeList = languages.map((language) {
      return Expanded(
        child: RadioListTile(
          title: Text(language['title']!),
          value: language['value'],
          groupValue: Localizations.localeOf(context).languageCode,
          onChanged: (languageCode) => _onLocaleChange(context, languageCode),
        ),
      );
    }).toList();
    final List<Widget> localeWidgetList =
        <Widget>[Text(tr.settingSelectLanguage)] + localeList;
    return Row(children: localeWidgetList);
  }

  _buildFontFamilySetting(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final List<Widget> fontFamilyWidgetList = [
      Text(tr.settingSelectFontFamily),
      DropdownButton<String>(
        value: FrontMaterialApp.getFontFamily(context),
        onChanged: (String? fontFamily) =>
            FrontMaterialApp.assignFontFamily(context, fontFamily),
        items: AppearanceConstant.FONT_FAMILIES
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    ];
    return Row(
        children: fontFamilyWidgetList,
        mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }

  _buildThemeSetting(BuildContext context) {
    final tr = AppLocalizations.of(context);
    List<Map<String, String>> themes = [
      {
        'title': tr.settingThemeBlue,
        'value': AppearanceConstant.THEME_BLUE,
      },
      {
        'title': tr.settingThemeGreen,
        'value': AppearanceConstant.THEME_GREEN,
      },
      {
        'title': tr.settingThemeRed,
        'value': AppearanceConstant.THEME_RED,
      },
    ];
    final List<Widget> themeWidgetList = [
      Text(tr.settingSelectTheme),
      DropdownButton(
        value: FrontMaterialApp.getThemeType(context),
        onChanged: (String? themeType) =>
            FrontMaterialApp.assignThemeType(context, themeType),
        items: themes.map((options) {
          return DropdownMenuItem(
            value: options['value'],
            child: Text(options['title']!),
          );
        }).toList(),
      ),
    ];
    return Row(
        children: themeWidgetList,
        mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }
}
