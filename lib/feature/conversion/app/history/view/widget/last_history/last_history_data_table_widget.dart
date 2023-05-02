import 'package:currency_calc/feature/conversion/app/history/view/widget/dto/history_output_row.dart';
import 'package:currency_calc/feature/conversion/infra/history/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/feature/front/app/view/theme/additional_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:intl/intl.dart';

class LastHistoryDataTableWidget extends StatefulWidget {
  @override
  _LastHistoryDataTableWidget createState() => _LastHistoryDataTableWidget();
}

class _LastHistoryDataTableWidget extends State<LastHistoryDataTableWidget> {
  late List<HistoryOutputRow> _historyRecords;

  static const LAST_HISTORY_RECORD_COUNT = 5;

  @override
  void initState() {
    super.initState();
    _historyRecords = [];
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context);
    _loadHistoryRecords(context);
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;

    return Visibility(
      visible: _historyRecords.isNotEmpty,
      child: DataTable(
        columnSpacing: 8,
        horizontalMargin: 16,
        decoration: BoxDecoration(
          color: additionalColors.linenColor,
          borderRadius: BorderRadius.circular(20),
        ),
        columns: [
          DataColumn(
              label: Text(appLoc.conversionHistoryDateColumnTitle),
              tooltip: appLoc.conversionHistoryDateColumnTooltip),
          DataColumn(
              label: Text(appLoc.conversionHistorySourceColumnTitle),
              tooltip: appLoc.conversionHistorySourceColumnTooltip),
          DataColumn(
              label: Text(appLoc.conversionHistoryTargetColumnTitle),
              tooltip: appLoc.conversionHistoryTargetColumnTooltip),
          DataColumn(
              label: Text(appLoc.conversionHistoryRateColumnTitle),
              tooltip: appLoc.conversionHistoryRateColumnTooltip),
          DataColumn(
              label: Text(appLoc.conversionHistoryActionsColumnTitle),
              tooltip: appLoc.conversionHistoryActionsColumnTooltip),
        ],
        rows: List.generate(
          _historyRecords.length,
          (index) => DataRow(
            cells: [
              DataCell(Text(_historyRecords[index].date,
                  style: TextStyle(fontSize: 12))),
              DataCell(Text(_historyRecords[index].from)),
              DataCell(Text(_historyRecords[index].to)),
              DataCell(Text(_historyRecords[index].rate)),
              DataCell(
                IconButton(
                  icon: Icon(Icons.delete,
                      size: 20, color: Theme.of(context).colorScheme.primary),
                  onPressed: () => _onDeletePressed(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onDeletePressed(int index) async {
    final repo = ConversionHistoryRecordRepository();
    await repo.init();
    final deleteIndex = repo.countAll() - index - 1;
    await repo.deleteByIndex(deleteIndex);
  }

  Future<void> _loadHistoryRecords(BuildContext context) async {
    final localeName = Localizations.localeOf(context).toString();
    final df = DateFormat.yMMMd(localeName);
    final tf = DateFormat.Hms(localeName);
    final nf = NumberFormat.decimalPattern(localeName);
    final repo = ConversionHistoryRecordRepository();
    await repo.init();
    final totalCount = repo.countAll();
    final skipCount = totalCount > LAST_HISTORY_RECORD_COUNT
        ? totalCount - LAST_HISTORY_RECORD_COUNT
        : 0;
    final historyRecords = await repo
        .loadAll() // box.values
        .skip(skipCount)
        .map((e) => HistoryOutputRow(
            df.format(e.date) + "\n" + tf.format(e.date),
            _formatCurrency(e.sourceAmount, e.sourceCurrency),
            _formatCurrency(e.targetAmount, e.targetCurrency),
            nf.format(e.rate)))
        .toList()
        .reversed
        .toList();
    setState(() {
      _historyRecords = historyRecords;
    });
  }

  String _formatCurrency(double amount, String currencyCode) {
    final localeName = Localizations.localeOf(context).toString();
    final format = NumberFormat.simpleCurrency(
      locale: localeName,
      name: currencyCode,
    );
    return format.format(amount);
  }
}
