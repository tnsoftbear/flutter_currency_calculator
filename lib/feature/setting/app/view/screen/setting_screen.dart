import 'package:currency_calc/feature/front/app/view/theme/additional_colors.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_header_bar.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            child: Table(
              columnWidths: {
                0: const FlexColumnWidth(0.25),
                1: const FlexColumnWidth(0.75),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                _buildLocaleSettingTableRow(context),
                _buildFontFamilySettingTableRow(context),
                _buildThemeSettingTableRow(context)
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

  _buildLocaleSettingTableRow(BuildContext context) {
    final tr = AppLocalizations.of(context);
    List<Map<String, String>> options = [
      {
        'title': tr.settingLocaleEnLabel,
        'value': AppearanceConstant.LC_EN,
        'icon': 'icons/flags/svg/us.svg',
      },
      {
        'title': tr.settingLocaleRuLabel,
        'value': AppearanceConstant.LC_RU,
        'icon': 'icons/flags/svg/ru.svg',
      },
    ];
    final List<Widget> languageWidgetList = options.map((language) {
      return Expanded(
          child: RadioListTile(
        title: SvgPicture.asset(language['icon']!,
            package: 'country_icons',
            height: 32,
            semanticsLabel: language['title']),
        value: language['value'],
        groupValue: Localizations.localeOf(context).languageCode,
        onChanged: (languageCode) => _onLocaleChange(context, languageCode),
      ));
    }).toList();
    return TableRow(children: [
      Text(tr.settingSelectLanguage),
      Row(
        children: languageWidgetList,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    ]);
  }

  _buildFontFamilySettingTableRow(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final List<Widget> fontFamilyWidgetList = [
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
    return TableRow(children: [
      Text(tr.settingSelectFontFamily),
      Row(
          children: fontFamilyWidgetList,
          mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ]);
  }

  _buildThemeSettingTableRow(BuildContext context) {
    final tr = AppLocalizations.of(context);
    List<Map<String, dynamic>> themes = [
      {
        'title': tr.settingThemeBlue,
        'value': AppearanceConstant.THEME_BLUE,
        'color': Colors.blue,
      },
      {
        'title': tr.settingThemeGreen,
        'value': AppearanceConstant.THEME_GREEN,
        'color': Colors.green,
      },
      {
        'title': tr.settingThemeRed,
        'value': AppearanceConstant.THEME_RED,
        'color': Colors.red,
      },
    ];
    final currentTheme = FrontMaterialApp.getThemeType(context);
    final List<Widget> themeWidgetList = themes.map((options) {
      return Expanded(
          child: RadioListTile(
        value: options['value'],
        groupValue: currentTheme,
        onChanged: (themeType) =>
            FrontMaterialApp.assignThemeType(context, themeType),
        secondary: Container(
          width: 16,
          height: 16,
          color: options['color'],
        ),
      ));
    }).toList();
    return TableRow(children: [
      Text(tr.settingSelectTheme),
      Row(
          children: themeWidgetList,
          mainAxisAlignment: MainAxisAlignment.spaceBetween)
    ]);
  }
}
