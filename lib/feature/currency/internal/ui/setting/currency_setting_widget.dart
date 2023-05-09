import 'package:currency_calc/feature/currency/internal/ui/setting/currency_setting_one_letter_tab.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/front/ui/widget/standard_error_label.dart';
import 'package:currency_calc/front/ui/widget/standard_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencySettingWidget extends StatelessWidget {
  const CurrencySettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currencyFeatureFacade = context.read<CurrencyFeatureFacade>();
    return FutureBuilder(
        future: currencyFeatureFacade.loadCurrencyLetters(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return StandardErrorLabel(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return StandardProgressIndicator();
          }

          final tabs =
              snapshot.data!.map((letter) => Tab(text: letter)).toList();
          final tabViews = snapshot.data!
              .map((letter) => CurrencySettingOneLetterTab(letter))
              .toList();

          return DefaultTabController(
            length: snapshot.data!.length,
            child: Column(
              children: [
                TabBar(labelColor: Theme.of(context).primaryColor, tabs: tabs),
                const SizedBox(height: 16),
                Expanded(child: TabBarView(children: tabViews)),
              ],
            ),
          );
        });
  }
}
