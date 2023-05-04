import 'package:currency_calc/feature/front/app/view/theme/additional_colors.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_header_bar.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/app/view/widget/setting_widget_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;
    final tr = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      animationDuration: const Duration(milliseconds: 500),
      child: Scaffold(
        appBar: FrontHeaderBar(
          titleText: tr.settingTitle,
          isSettingMenu: false,
          // bottom: TabBar(
          //   controller: _tabController,
          //   tabs: [
          //     Tab(text: tr.settingTabAppearance),
          //     Tab(text: tr.settingTabCurrency),
          //   ],
          // ),
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
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: additionalColors.linenTurbidColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TabBar(
                  labelColor: Theme.of(context).primaryColor,
                  tabs: [
                    Tab(text: tr.settingTabAppearance),
                    Tab(text: tr.settingTabCurrency),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(
                    children: [
                      Table(
                        columnWidths: {
                          0: const FlexColumnWidth(0.25),
                          1: const FlexColumnWidth(0.75),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          LocaleSettingTableRow(context),
                          FontFamilySettingTableRow(context),
                          ThemeSettingTableRow(context),
                        ],
                      ),
                      VisibleCurrencySetting(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
