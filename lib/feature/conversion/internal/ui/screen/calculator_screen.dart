import 'package:currency_calc/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/front/ui/widget/front_header_bar.dart';
import 'package:currency_calc/front/ui/widget/front_main_menu.dart';
import 'package:currency_calc/feature/history/public/history_feature_facade.dart';
import 'package:currency_calc/feature/conversion/internal/ui/widget/calculator/calculator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lastHistoryWidget =
        context.read<HistoryFeatureFacade>().createLastHistoryWidget();
    final lastHistoryModel =
        context.read<HistoryFeatureFacade>().createLastHistoryModel();
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
          create: (_) => lastHistoryModel,
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
