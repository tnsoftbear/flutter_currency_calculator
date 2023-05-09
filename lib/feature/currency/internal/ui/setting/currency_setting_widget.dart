import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_checkbox.dart';
import 'package:currency_calc/front/ui/widget/standard_error_label.dart';
import 'package:currency_calc/front/ui/widget/standard_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CurrencySettingWidget extends StatelessWidget {
  const CurrencySettingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
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
