import 'package:currency_calc/feature/setting/internal/ui/widget/appearance/option/appearance_setting_option_export.dart';
import 'package:flutter/cupertino.dart';

class AppearanceSetting extends StatelessWidget {
  const AppearanceSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: {
        0: const FlexColumnWidth(0.25),
        1: const FlexColumnWidth(0.75),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        LocaleSettingTableRow(context),
        FontFamilySettingTableRow(context),
        ThemeSettingTableRow(context),
      ],
    );
  }
}
