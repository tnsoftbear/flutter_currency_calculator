import 'package:currency_calc/feature/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/front/ui/widget/front_header_bar.dart';
import 'package:currency_calc/feature/front/ui/widget/front_main_menu.dart';
import 'package:currency_calc/feature/history/internal/app/model/last_history_model.dart';
import 'package:currency_calc/feature/history/internal/infra/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/feature/history/public/history_feature_facade.dart';
import 'package:currency_calc/feature/conversion/internal/ui/widget/calculator/calculator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lastHistoryWidget =
        context.read<HistoryFeatureFacade>().createLastHistoryWidget();
    return Scaffold(
      appBar: FrontHeaderBar(
          titleText: AppLocalizations.of(context).conversionTitle),
      drawer: const FrontMainMenu(),
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
              Container(height: 300, child: lastHistoryWidget),
            ],
          ),
        ),
      ),
    );
  }
}
