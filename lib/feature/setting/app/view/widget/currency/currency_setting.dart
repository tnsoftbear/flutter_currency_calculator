import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/front/app/view/widget/standard_error_label.dart';
import 'package:currency_calc/feature/front/app/view/widget/standard_progress_indicator.dart';
import 'package:currency_calc/feature/setting/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class CurrencySetting extends StatelessWidget {
  const CurrencySetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final settingModel = context.watch<SettingModel>();
    final currencyFeatureFacade = context.read<CurrencyFeatureFacade>();
    return FutureBuilder(
        future: currencyFeatureFacade.loadAllCurrencies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return StandardErrorLabel(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return StandardProgressIndicator();
          }

          final theme = Theme.of(context);

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: theme.primaryColor),
                    children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingCurrencyCode,
                            style: theme.primaryTextTheme.titleSmall,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingCurrencyName,
                            style: theme.primaryTextTheme.titleSmall,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingSourceCurrency,
                            style: theme.primaryTextTheme.titleSmall,
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingTargetCurrency,
                            style: theme.primaryTextTheme.titleSmall,
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var currency in snapshot.data as List<Currency>)
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(currency.code),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(currency.name),
                          ),
                        ),
                        TableCell(
                          child: Checkbox(
                              key: Key(
                                  'visibleSourceCurrencyCodes_${currency.code}'),
                              value: currency.isVisibleForSource,
                              onChanged: (bool? visible) =>
                                  _onChangedVisibleSourceCurrency(
                                      currency.code, visible, settingModel)),
                        ),
                        TableCell(
                          child: Checkbox(
                              key: Key(
                                  'visibleTargetCurrencyCodes_${currency.code}'),
                              value: currency.isVisibleForTarget,
                              onChanged: (bool? visible) =>
                                  _onChangedVisibleTargetCurrency(
                                      currency.code, visible, settingModel)),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }

  void _onChangedVisibleSourceCurrency(
      String currencyCode, bool? visible, SettingModel settingModel) {
    visible ??= false;
    final currencyCodes =
        List<String>.from(settingModel.visibleSourceCurrencyCodes);
    print(currencyCodes);
    if (visible) {
      currencyCodes.add(currencyCode);
    } else {
      // Reject to remove last currency.
      if (currencyCodes.length == 1) {
        return;
      }
      currencyCodes.remove(currencyCode);
    }
    settingModel.setVisibleSourceCurrencyCodes(currencyCodes);

    // Replace selected source currency, if it is absent in drop-down list
    if (!currencyCodes.contains(settingModel.selectedSourceCurrencyCode)) {
      if (currencyCodes.length > 1 &&
          settingModel.selectedTargetCurrencyCode == currencyCodes.first) {
        // Replace with the second currency from the visible currency list,
        // because the first currency is already selected as target currency.
        settingModel.setSourceCurrencyCode(currencyCodes[1]);
      } else {
        // Replace with the first currency in the visible currency list
        settingModel.setSourceCurrencyCode(currencyCodes.first);
      }
    }
  }

  void _onChangedVisibleTargetCurrency(
      String currencyCode, bool? visible, SettingModel settingModel) {
    visible ??= false;
    final currencyCodes =
        List<String>.from(settingModel.visibleTargetCurrencyCodes);
    if (visible) {
      currencyCodes.add(currencyCode);
    } else {
      // Reject to remove last currency.
      if (currencyCodes.length == 1) {
        return;
      }
      currencyCodes.remove(currencyCode);
    }
    settingModel.setVisibleTargetCurrencyCodes(currencyCodes);

    // Replace selected target currency, if it is absent in drop-down list
    if (!currencyCodes.contains(settingModel.selectedTargetCurrencyCode)) {
      if (currencyCodes.length > 1 &&
          settingModel.selectedSourceCurrencyCode == currencyCodes.first) {
        // Replace with the second currency in the visible currency list,
        // because the first currency is already selected as source currency.
        settingModel.setTargetCurrencyCode(currencyCodes[1]);
      } else {
        // Replace with the first currency in the visible currency list
        settingModel.setTargetCurrencyCode(currencyCodes.first);
      }
    }
  }
}
