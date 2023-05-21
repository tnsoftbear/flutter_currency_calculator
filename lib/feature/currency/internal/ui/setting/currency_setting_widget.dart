import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_setting_one_letter_tab.dart';
import 'package:currency_calc/front/ui/widget/standard_error_label.dart';
import 'package:currency_calc/front/ui/widget/standard_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';

class CurrencySettingWidget extends StatelessWidget {
  const CurrencySettingWidget(CurrencyRepository this._currencyRepository,
      CurrencyVisibilityUpdater this._currencyVisibilityUpdater,
      {Key? key})
      : super(key: key);

  final CurrencyRepository _currencyRepository;
  final CurrencyVisibilityUpdater _currencyVisibilityUpdater;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _currencyRepository.loadCurrencyCodeFirstLetters(),
        builder: (context, letters) {
          if (letters.hasError) {
            return StandardErrorLabel(letters.error.toString());
          } else if (!letters.hasData) {
            return StandardProgressIndicator();
          }

          final tabs =
              letters.data!.map((letter) => Tab(text: letter)).toList();
          final tabViews = letters.data!
              .map((letter) => CurrencySettingOneLetterTab(
                  letter, _currencyRepository, _currencyVisibilityUpdater))
              .toList();
          final theme = Theme.of(context);

          return DefaultTabController(
            length: letters.data!.length,
            child: VerticalTabs(
                materialType: MaterialType.transparency,
                backgroundColor: Colors.transparent,
                tabBackgroundColor: Colors.transparent,
                selectedTabBackgroundColor: theme.primaryColor.withOpacity(0.2),
                tabsWidth: 50,
                contentScrollAxis: Axis.vertical,
                indicatorColor: theme.primaryColor,
                indicatorSide: IndicatorSide.start,
                tabs: tabs,
                contents: tabViews),
          );
        });
  }
}
