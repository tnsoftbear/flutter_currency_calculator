import 'package:currency_calc/feature/about/public/about_feature_facade.dart';
import 'package:currency_calc/feature/conversion/public/conversion_feature_facade.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/history/public/history_feature_facade.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model_manager.dart';
import 'package:currency_calc/feature/setting/public/setting_feature_facade.dart';
import 'package:currency_calc/front/ui/widget/front_material_app.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

final class Bootstrapper {
  static Future<MultiProvider> setup() async {
    _init();

    final currencyFeatureFacade = CurrencyFeatureFacade();
    await currencyFeatureFacade.populateIfNeeded();

    final settingModelManager = SettingModelManager(currencyFeatureFacade);
    final settingModel = await SettingModel(settingModelManager).init();

    FlutterNativeSplash.remove();

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => settingModel),
      Provider(create: (_) => AboutFeatureFacade()),
      Provider(create: (_) => ConversionFeatureFacade()),
      Provider(create: (_) => currencyFeatureFacade),
      Provider(create: (_) => HistoryFeatureFacade()),
      Provider(create: (_) => SettingFeatureFacade()),
    ], child: const FrontMaterialApp());
  }

  static Future<void> _init() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await Hive.initFlutter();
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
