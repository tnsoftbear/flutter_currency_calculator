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
    final visibleSourceCurrencyCodes = settingModel.visibleSourceCurrencyCodes;
    final visibleTargetCurrencyCodes = settingModel.visibleTargetCurrencyCodes;
    final currencyFeatureFacade = context.read<CurrencyFeatureFacade>();
    return FutureBuilder(
        future: currencyFeatureFacade.loadAllCurrencyCodes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return StandardErrorLabel(snapshot.error.toString());
          } else if (!snapshot.hasData) {
            return StandardProgressIndicator();
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(2),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration:
                        BoxDecoration(color: Theme.of(context).primaryColor),
                    children: [
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingSourceCurrency,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingCurrencyVisible,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingTargetCurrency,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            tr.settingCurrencyVisible,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var currency in snapshot.data as List<String>)
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(currency),
                          ),
                        ),
                        TableCell(
                          child: Checkbox(
                              key: Key('visibleSourceCurrencyCodes_$currency'),
                              value:
                                  visibleSourceCurrencyCodes.contains(currency),
                              onChanged: (bool? visible) =>
                                  _onChangedVisibleSourceCurrency(
                                      currency, visible, settingModel)),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(currency),
                          ),
                        ),
                        TableCell(
                          child: Checkbox(
                              key: Key('visibleTargetCurrencyCodes_$currency'),
                              value:
                                  visibleTargetCurrencyCodes.contains(currency),
                              onChanged: (bool? visible) =>
                                  _onChangedVisibleTargetCurrency(
                                      currency, visible, settingModel)),
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
