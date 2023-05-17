import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/setting/internal/ui/widget/appearance/appearance_setting.dart';
import 'package:currency_calc/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/front/ui/theme/additional_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

final class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final AdditionalColors additionalColors =
        theme.extension<AdditionalColors>()!;
    final tr = AppLocalizations.of(context);
    final currencySettingWidget =
        context.read<CurrencyFeatureFacade>().createCurrencySettingWidget();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(tr.settingTitle),
          bottom: TabBar(
            labelColor: theme.listTileTheme.textColor,
            tabs: [
              Tab(text: tr.settingTabAppearance),
              Tab(text: tr.settingTabCurrency),
            ],
          ),
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
            decoration: BoxDecoration(
              color: additionalColors.linenTurbidColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: TabBarView(
                    children: [
                      AppearanceSetting(),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 4),
                          child: currencySettingWidget),
                      //currencySettingWidget,
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
