import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:currency_calc/feature/setting/app/manage/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LocaleSettingTableRow extends TableRow {
  final BuildContext context;

  LocaleSettingTableRow(
    BuildContext this.context,
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
      final settingModel = context.read<SettingModel>();
      return Expanded(
          child: RadioListTile(
            title: SvgPicture.asset(language['icon']!,
                package: 'country_icons',
                height: 32,
                semanticsLabel: language['title']),
            value: language['value'],
            groupValue: settingModel.languageCode,
            onChanged: (languageCode) => settingModel.setLanguageCode(languageCode),
          ));
    }).toList();

    return languageWidgetList;
  }
}