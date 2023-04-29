import 'package:currency_calc/feature/conversion/app/history/view/widget/dto/history_output_row.dart';
import 'package:currency_calc/feature/conversion/infra/history/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/feature/front/app/view/theme/additional_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:intl/intl.dart';

import 'all_history_data_table_source.dart';

class AllHistoryDataTableWidget extends StatefulWidget {
  @override
  _HistoryDataTableWidget createState() => _HistoryDataTableWidget();
}

class _HistoryDataTableWidget extends State<AllHistoryDataTableWidget> {
  late List<HistoryOutputRow> _historyRecords;

  @override
  void initState() {
    super.initState();
    _historyRecords = [];
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    _loadHistoryRecords(context);
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;

    return Container(
        width: 400,
        decoration: BoxDecoration(
          color: additionalColors.linenColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Theme(
            data: Theme.of(context)
                .copyWith(cardColor: additionalColors.linenColor),
            child: _historyRecords.isEmpty
                ? Center(
                    child: Text(
                    tr.conversionHistoryEmptyMessage,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ))
                : PaginatedDataTable(
                    rowsPerPage: 10,
                    columnSpacing: 8,
                    horizontalMargin: 8,
                    columns: [
                      DataColumn(
                          label: Text(tr.conversionHistoryDateColumnTitle),
                          tooltip: tr.conversionHistoryDateColumnTooltip),
                      DataColumn(
                          label: Text(tr.conversionHistorySourceColumnTitle),
                          tooltip: tr.conversionHistorySourceColumnTooltip),
                      DataColumn(
                          label: Text(tr.conversionHistoryTargetColumnTitle),
                          tooltip: tr.conversionHistoryTargetColumnTooltip),
                      DataColumn(
                          label: Text(tr.conversionHistoryRateColumnTitle),
                          tooltip: tr.conversionHistoryRateColumnTooltip),
                      DataColumn(
                          label: Text(tr.conversionHistoryActionsColumnTitle),
                          tooltip: tr.conversionHistoryActionsColumnTooltip),
                    ],
                    source: AllHistoryDataTableSource(context, _historyRecords),
                  )));
  }

  Future<void> _loadHistoryRecords(BuildContext context) async {
    final localeName = Localizations.localeOf(context).toString();
    final df = DateFormat.yMMMd(localeName);
    final tf = DateFormat.Hms(localeName);
    final nf = NumberFormat.decimalPattern(localeName);
    final repo = ConversionHistoryRecordRepository();
    await repo.init();
    final historyRecords = repo
        .loadAll()
        .map((e) => HistoryOutputRow(
            df.format(e.date) + "\n" + tf.format(e.date),
            _formatCurrency(e.sourceAmount, e.sourceCurrency),
            _formatCurrency(e.targetAmount, e.targetCurrency),
            nf.format(e.rate)))
        .toList();
    setState(() {
      _historyRecords = historyRecords;
    });
  }

  String _formatCurrency(double amount, String currencyCode) {
    final localeName = Localizations.localeOf(context).toString();
    final format = NumberFormat.currency(
      locale: localeName,
      name: currencyCode,
    );
    return format.format(amount);
  }
}
