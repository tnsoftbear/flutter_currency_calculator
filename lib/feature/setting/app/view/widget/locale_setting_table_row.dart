import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocaleSettingTableRow extends TableRow {
  final BuildContext context;

  LocaleSettingTableRow(
    this.context,
  ) : super(children: [
    Text(AppLocalizations.of(context).settingSelectLanguage),
    Row(
      children: _buildLocaleList(context),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    )
  ]);

  static List<Widget> _buildLocaleList(BuildContext context) {
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
    ];;

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

    return languageWidgetList;
  }

  static _onLocaleChange(BuildContext context, String? languageCode) {
    languageCode = languageCode ?? AppearanceConstant.LC_DEFAULT;
    final countryCode = AppearanceConstant.CONFIG[languageCode]!['countryCode'];
    final locale = Locale(languageCode, countryCode);
    FrontMaterialApp.assignLocale(context, locale);
  }
}