import 'package:currency_calc/feature/conversion/domain/constant/currency_constant.dart';
import 'package:currency_calc/feature/setting/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class VisibleCurrencySetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final settingModel = context.watch<SettingModel>();
    final visibleSourceCurrencyCodes = settingModel.visibleSourceCurrencyCodes;
    final visibleTargetCurrencyCodes = settingModel.visibleTargetCurrencyCodes;
    return Container(
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
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
          for (var currency in CurrencyConstant.CURRENCY_CODES)
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
                      value: visibleSourceCurrencyCodes.contains(currency),
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
                      value: visibleTargetCurrencyCodes.contains(currency),
                      onChanged: (bool? visible) =>
                          _onChangedVisibleTargetCurrency(
                              currency, visible, settingModel)),
                ),
              ],
            ),
        ],
      ),
    );
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
    // Replace selected source currency, if it is absent in drop-down list
    if (!currencyCodes.contains(settingModel.selectedSourceCurrencyCode)) {
      if (currencyCodes.length > 1 &&
          settingModel.selectedTargetCurrencyCode == currencyCodes.first) {
        // Replace with the second currency from the visible currency list,
        // because the first currency is already selected as target currency.
        settingModel
            .setSourceCurrencyCode(currencyCodes[1]);
      } else {
        // Replace with the first currency in the visible currency list
        settingModel.setSourceCurrencyCode(currencyCodes.first);
      }
    }
    settingModel.setVisibleSourceCurrencyCodes(currencyCodes);
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
    // Replace selected target currency, if it is absent in drop-down list
    if (!currencyCodes.contains(settingModel.selectedTargetCurrencyCode)) {
      if (currencyCodes.length > 1 &&
          settingModel.selectedSourceCurrencyCode == currencyCodes.first) {
        // Replace with the second currency in the visible currency list,
        // because the first currency is already selected as source currency.
        settingModel
            .setTargetCurrencyCode(currencyCodes[1]);
      } else {
        // Replace with the first currency in the visible currency list
        settingModel.setTargetCurrencyCode(currencyCodes.first);
      }
    }
    settingModel.setVisibleTargetCurrencyCodes(currencyCodes);
  }
}
