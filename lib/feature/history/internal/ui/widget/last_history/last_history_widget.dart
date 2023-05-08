import 'package:currency_calc/feature/front/ui/theme/additional_colors.dart';
import 'package:currency_calc/feature/front/ui/widget/standard_error_label.dart';
import 'package:currency_calc/feature/front/ui/widget/standard_progress_indicator.dart';
import 'package:currency_calc/feature/history/internal/app/model/last_history_model.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/dto/history_output_dto.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/last_history/last_history_output_dto_producer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class LastHistoryWidget extends StatelessWidget {
  const LastHistoryWidget();

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            );
          }

          if (snapshot.hasError) {
            return StandardErrorLabel(snapshot.error.toString());
          }

          return StandardProgressIndicator();
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
