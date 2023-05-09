import 'package:currency_calc/feature/currency/internal/ui/setting/currency_checkbox.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CurrencySettingOneLetterTab extends StatelessWidget {
  final String letter;

  CurrencySettingOneLetterTab(
      String this.letter,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final currencyFeatureFacade = context.read<CurrencyFeatureFacade>();
    return FutureBuilder(
        future: currencyFeatureFacade.loadOneLetterCurrencies(letter),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text(snap.error.toString()));
          } else if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(1.5),
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
                  for (var currency in snap.data as List<Currency>)
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
                          child: CurrencyCheckbox(currency, true),
                        ),
                        TableCell(
                          child: CurrencyCheckbox(currency, false),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        });
  }
}
