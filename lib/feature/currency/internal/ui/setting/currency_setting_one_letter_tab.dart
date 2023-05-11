import 'package:currency_calc/feature/currency/internal/app/load/currency_loader.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_checkbox.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CurrencySettingOneLetterTab extends StatelessWidget {
  CurrencySettingOneLetterTab(
      String this._letter,
      CurrencyLoader this._currencyLoader,
      CurrencyRepository this._currencyRepository,
      {Key? key})
      : super(key: key);

  final String _letter;
  final CurrencyLoader _currencyLoader;
  final CurrencyRepository _currencyRepository;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return FutureBuilder(
        future: _currencyLoader.loadCurrenciesByCodeFirstLetter(_letter),
        builder: (context, snap) {
          if (snap.hasError) {
            return Center(child: Text(snap.error.toString()));
          } else if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final padding =
              const EdgeInsets.symmetric(vertical: 8, horizontal: 4);
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: EdgeInsets.all(4),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(4),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: theme.primaryColor),
                    children: [
                      TableCell(
                        child: Padding(
                            padding: padding,
                            child: Text(
                              tr.settingCurrencyCode,
                              style: theme.primaryTextTheme.titleSmall,
                            )),
                      ),
                      TableCell(
                        child: Padding(
                            padding: padding,
                            child: Text(
                              tr.settingCurrencyName,
                              style: theme.primaryTextTheme.titleSmall,
                            )),
                      ),
                      TableCell(
                        child: Padding(
                            padding: padding,
                            child: Text(
                              tr.settingSourceCurrency,
                              style: theme.primaryTextTheme.titleSmall,
                            )),
                      ),
                      TableCell(
                        child: Padding(
                            padding: padding,
                            child: Text(
                              tr.settingTargetCurrency,
                              style: theme.primaryTextTheme.titleSmall,
                            )),
                      ),
                    ],
                  ),
                  for (var currency in snap.data as List<Currency>)
                    TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: padding,
                            child: Text(currency.code),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: padding,
                            child: Text(currency.name),
                          ),
                        ),
                        TableCell(
                          child: CurrencyCheckbox(
                              currency, true, _currencyRepository),
                        ),
                        TableCell(
                          child: CurrencyCheckbox(
                              currency, false, _currencyRepository),
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
