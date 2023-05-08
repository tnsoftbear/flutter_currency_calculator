import 'package:currency_calc/feature/conversion/domain/history/model/conversion_history_record.dart';
import 'package:currency_calc/feature/conversion/domain/rate/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:currency_calc/feature/setting/app/manage/setting_manager.dart';
import 'package:currency_calc/feature/setting/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConversionHistoryRecordAdapter());
  Hive.registerAdapter(ExchangeRateRecordAdapter());

  final currencyFeatureFacade = CurrencyFeatureFacade();
  await currencyFeatureFacade.populateIfNeeded();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  final settingManager = SettingManager(currencyFeatureFacade);
  final settingModel = await SettingModel(settingManager).init();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => settingModel),
    Provider(create: (_) => currencyFeatureFacade),
  ], child: const FrontMaterialApp()));
}
