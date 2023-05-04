import 'package:currency_calc/feature/conversion/domain/history/model/conversion_history_record.dart';
import 'package:currency_calc/feature/conversion/domain/rate/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:currency_calc/feature/setting/app/manage/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConversionHistoryRecordAdapter());
  Hive.registerAdapter(ExchangeRateRecordAdapter());

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final settingModel = await SettingModel().init();

  runApp(
      ChangeNotifierProvider(
        create: (_) => settingModel,
        child: FrontMaterialApp()
      )
  );
}
