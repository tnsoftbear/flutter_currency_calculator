import 'package:currency_calc/feature/history/internal/ui/widget/history_output/history_output_dto_producer.dart';
import 'package:currency_calc/front/ui/theme/additional_colors.dart';
import 'package:currency_calc/feature/history/internal/domain/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/history_output/history_output_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'all_history_data_table_source.dart';

final class AllHistoryDataTableWidget extends StatefulWidget {
  AllHistoryDataTableWidget(this.conversionHistoryRecordRepository, {Key? key})
      : super(key: key);

  final ConversionHistoryRecordRepository conversionHistoryRecordRepository;

  @override
  _HistoryDataTableWidget createState() => _HistoryDataTableWidget();
}

final class _HistoryDataTableWidget extends State<AllHistoryDataTableWidget> {
  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;

    return FutureBuilder(
        future: _produceOutputDtos(context),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return Container(
              width: 400,
              decoration: BoxDecoration(
                color: additionalColors.linenColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Theme(
                  data: Theme.of(context)
                      .copyWith(cardColor: additionalColors.linenColor),
                  child: snapshot.data!.isEmpty
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
                                label:
                                    Text(tr.conversionHistoryDateColumnTitle),
                                tooltip: tr.conversionHistoryDateColumnTooltip),
                            DataColumn(
                                label:
                                    Text(tr.conversionHistorySourceColumnTitle),
                                tooltip:
                                    tr.conversionHistorySourceColumnTooltip),
                            DataColumn(
                                label:
                                    Text(tr.conversionHistoryTargetColumnTitle),
                                tooltip:
                                    tr.conversionHistoryTargetColumnTooltip),
                            DataColumn(
                                label:
                                    Text(tr.conversionHistoryRateColumnTitle),
                                tooltip: tr.conversionHistoryRateColumnTooltip),
                            DataColumn(
                                label: Text(
                                    tr.conversionHistoryActionsColumnTitle),
                                tooltip:
                                    tr.conversionHistoryActionsColumnTooltip),
                          ],
                          source: AllHistoryDataTableSource(
                              context, snapshot.data!, deleteRecord))));
        });
  }

  Future<List<HistoryOutputDto>> _produceOutputDtos(
      BuildContext context) async {
    final localeName = Localizations.localeOf(context).toString();
    final records = await widget.conversionHistoryRecordRepository.loadAll();
    final historyOutputDtos =
        HistoryOutputDtoProducer.produce(records, localeName);
    return historyOutputDtos;
  }

  void deleteRecord(int index) {
    widget.conversionHistoryRecordRepository.deleteByIndex(index);
    setState(() {});
  }
}
