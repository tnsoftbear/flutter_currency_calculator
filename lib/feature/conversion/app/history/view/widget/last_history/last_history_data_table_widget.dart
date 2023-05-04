import 'package:currency_calc/feature/conversion/app/history/model/last_history_model.dart';
import 'package:currency_calc/feature/conversion/app/history/view/widget/dto/history_output_dto.dart';
import 'package:currency_calc/feature/conversion/app/history/view/widget/last_history/last_history_output_dto_producer.dart';
import 'package:currency_calc/feature/front/app/view/theme/additional_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class LastHistoryDataTableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context);
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;
    return FutureBuilder<List<HistoryOutputDto>>(
        future: _produceOutputDtos(context),
        builder: (BuildContext context,
            AsyncSnapshot<List<HistoryOutputDto>> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              children = [];
            } else {
              final data = snapshot.data!;
              children = [
                DataTable(
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
                    data.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(Text(data[index].date,
                            style: TextStyle(fontSize: 12))),
                        DataCell(Text(data[index].from)),
                        DataCell(Text(data[index].to)),
                        DataCell(Text(data[index].rate)),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary),
                            onPressed: () => _onDeletePressed(context, index),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ];
            }
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              ),
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              ),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        });
  }

  _onDeletePressed(BuildContext context, int index) async {
    context.read<LastHistoryModel>().deleteRecordByTableIndex(index);
  }

  Future<List<HistoryOutputDto>> _produceOutputDtos(
      BuildContext context) async {
    final localeName = Localizations.localeOf(context).toString();
    final records = await context.watch<LastHistoryModel>().load();
    final historyOutputDtos =
        LastHistoryOutputDtoProducer.produce(records, localeName);
    return historyOutputDtos;
  }
}
