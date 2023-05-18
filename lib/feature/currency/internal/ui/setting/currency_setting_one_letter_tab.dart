import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_checkbox.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class CurrencySettingOneLetterTab extends StatelessWidget {
  CurrencySettingOneLetterTab(
      String this._letter,
      CurrencyRepository this._currencyRepository,
      CurrencyVisibilityUpdater this._currencyVisibilityUpdater,
      {Key? key})
      : super(key: key);

  final String _letter;
  final CurrencyRepository _currencyRepository;
  final CurrencyVisibilityUpdater _currencyVisibilityUpdater;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _currencyRepository.loadCurrenciesByCodeFirstLetter(_letter),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
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
                  headerRow(context, padding),
                  for (var currency in snapshot.data as List<Currency>)
                    dataRow(currency, padding),
                ],
              ),
            ),
          );
        });
  }

  TableRow headerRow(BuildContext context, EdgeInsets padding) {
    final tr = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return TableRow(
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
    );
  }

  TableRow dataRow(Currency currency, EdgeInsets padding) {
    return TableRow(
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
              currency, true, _currencyVisibilityUpdater),
        ),
        TableCell(
          child: CurrencyCheckbox(
              currency, false, _currencyVisibilityUpdater),
        ),
      ],
    );
  }
}
