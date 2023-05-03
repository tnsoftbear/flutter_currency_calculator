import 'package:currency_calc/feature/conversion/app/history/model/last_history_model.dart';
import 'package:currency_calc/feature/conversion/app/history/view/widget/last_history/last_history_data_table_widget.dart';
import 'package:currency_calc/feature/conversion/app/rate/view/widget/calculator/calculator_widget.dart';
import 'package:currency_calc/feature/conversion/infra/history/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_header_bar.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_main_menu.dart';
import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  CalculatorScreenState createState() => CalculatorScreenState();
}

class CalculatorScreenState extends State<CalculatorScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FrontHeaderBar(
          titleText: AppLocalizations.of(context).conversionTitle),
      drawer: FrontMainMenu(),
      body: Container(
        padding: EdgeInsets.only(bottom: 16),
        decoration: const BoxDecoration(
          image: const DecorationImage(
            image: const AssetImage(
                AppearanceConstant.BG_IMAGE_FOR_CURRENCY_CONVERSION_SCREEN),
            fit: BoxFit.cover,
          ),
        ),
        child: ChangeNotifierProvider(
          create: (context) =>
              LastHistoryModel(ConversionHistoryRecordRepository()),
          child: Column(
            children: [
              Container(
                child: CalculatorWidget(),
              ),
              Container(height: 300, child: LastHistoryDataTableWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
