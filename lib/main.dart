import 'package:currency_calc/feature/about/public/about_feature_facade.dart';
import 'package:currency_calc/feature/conversion/public/conversion_feature_facade.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/front/ui/widget/front_material_app.dart';
import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:currency_calc/feature/history/public/history_feature_facade.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model_manager.dart';
import 'package:currency_calc/feature/setting/public/setting_feature_facade.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final currencyFeatureFacade = CurrencyFeatureFacade();
  await currencyFeatureFacade.populateIfNeeded();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final settingModelManager = SettingModelManager(currencyFeatureFacade);
  final settingModel = await SettingModel(settingModelManager).init();

  final aboutFeatureFacade = AboutFeatureFacade();
  final conversionFeatureFacade = ConversionFeatureFacade();
  final historyFeatureFacade = HistoryFeatureFacade();
  final settingFeatureFacade = SettingFeatureFacade();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => settingModel),
    Provider(create: (_) => currencyFeatureFacade),
    Provider(create: (_) => aboutFeatureFacade),
    Provider(create: (_) => settingFeatureFacade),
    Provider(create: (_) => historyFeatureFacade),
    Provider(create: (_) => conversionFeatureFacade),
  ], child: const FrontMaterialApp()));
}
