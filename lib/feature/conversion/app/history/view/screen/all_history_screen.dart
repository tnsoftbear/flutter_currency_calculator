import 'package:currency_calc/feature/conversion/app/history/view/widget/all_history/all_history_data_table_widget.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_header_bar.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_main_menu.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';

class AllHistoryScreen extends StatefulWidget {
  @override
  _AllHistoryScreenState createState() => _AllHistoryScreenState();
}

class _AllHistoryScreenState extends State<AllHistoryScreen> {
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
          child: Center(child: AllHistoryDataTableWidget()),
        ));
  }
}
