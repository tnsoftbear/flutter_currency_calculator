import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';

class ThemeSettingTableRow extends TableRow {
  final BuildContext context;

  ThemeSettingTableRow(
    this.context,
  ) : super(children: [
    Text(AppLocalizations.of(context).settingSelectTheme),
    Row(
      children: _buildThemeList(context),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    )
  ]);

  static List<Widget> _buildThemeList(BuildContext context) {
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
        ),
      );
    }).toList();

    return themeWidgetList;
  }
}
