import 'package:currency_calc/feature/history/internal/ui/widget/history_output/history_output_dto.dart';
import 'package:flutter/material.dart';

final class AllHistoryDataTableSource extends DataTableSource {
  AllHistoryDataTableSource(
      BuildContext this._context,
      List<HistoryOutputDto> this._historyRecords,
      Function this._deleteRecord);

  BuildContext _context;
  List<HistoryOutputDto> _historyRecords;
  Function _deleteRecord;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _historyRecords.length;

  @override
  int get selectedRowCount => 0;

  DataRow getRow(int index) {
    index = _historyRecords.length - index - 1;
    return DataRow(
      cells: [
        DataCell(
            Text(_historyRecords[index].date, style: TextStyle(fontSize: 12))),
        DataCell(Text(_historyRecords[index].from)),
        DataCell(Text(_historyRecords[index].to)),
        DataCell(Text(_historyRecords[index].rate)),
        DataCell(
          IconButton(
            icon: Icon(Icons.delete,
                size: 20, color: Theme.of(_context).colorScheme.primary),
            onPressed: () => _deleteRecord(index),
          ),
        ),
      ],
    );
  }
}
