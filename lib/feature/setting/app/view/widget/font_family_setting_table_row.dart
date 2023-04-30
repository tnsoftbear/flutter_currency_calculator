import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';

class FontFamilySettingTableRow extends TableRow {
  FontFamilySettingTableRow(BuildContext context)
      : super(children: [
          Text(AppLocalizations.of(context).settingSelectFontFamily),
          Row(
            children: [
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
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ]);
}
