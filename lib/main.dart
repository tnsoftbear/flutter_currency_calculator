import 'package:currency_calc/feature/conversion/domain/history/model/conversion_history_record.dart';
import 'package:currency_calc/feature/conversion/domain/rate/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/front/app/view/widget/front_material_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ConversionHistoryRecordAdapter());
  Hive.registerAdapter(ExchangeRateRecordAdapter());

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(FrontMaterialApp());
}
