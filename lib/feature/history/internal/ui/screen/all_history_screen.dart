import 'package:currency_calc/feature/history/internal/domain/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/front/ui/widget/front_header_bar.dart';
import 'package:currency_calc/front/ui/widget/front_main_menu.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/all_history/all_history_data_table_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class AllHistoryScreen extends StatelessWidget {
  AllHistoryScreen(this._conversionHistoryRecordRepository, {Key? key})
      : super(key: key);

  final ConversionHistoryRecordRepository _conversionHistoryRecordRepository;

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    return Scaffold(
        appBar: FrontHeaderBar(titleText: tr.conversionHistoryTitle),
        drawer: const FrontMainMenu(),
        body: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            image: const DecorationImage(
              image: const AssetImage(AppearanceConstant
                  .BG_IMAGE_FOR_CURRENCY_CONVERSION_ALL_HISTORY_SCREEN),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
              child: AllHistoryDataTableWidget(
                  _conversionHistoryRecordRepository)),
        ));
  }
}
