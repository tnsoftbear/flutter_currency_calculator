import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class FontFamilySettingTableRow extends TableRow {
  FontFamilySettingTableRow(BuildContext context)
      : super(children: [
          Text(AppLocalizations.of(context).settingSelectFontFamily),
          _buildFontFamilyDropdown(context),
        ]);

  static DropdownButton _buildFontFamilyDropdown(BuildContext context) {
    final menuItemList =
        AppearanceConstant.FONT_FAMILIES.map((String fontFamily) {
      return DropdownMenuItem<String>(
          value: fontFamily, child: Text(fontFamily));
    }).toList();

    final settingModel = context.read<SettingModel>();
    return DropdownButton(
        value: settingModel.fontFamily,
        items: menuItemList,
        onChanged: (fontFamily) => settingModel.setFontFamily(fontFamily));
  }
}
