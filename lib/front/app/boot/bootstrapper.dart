import 'package:currency_calc/feature/about/public/about_feature_facade.dart';
import 'package:currency_calc/feature/conversion/public/conversion_feature_facade.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/front/ui/widget/front_material_app.dart';
import 'package:currency_calc/feature/history/public/history_feature_facade.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model_manager.dart';
import 'package:currency_calc/feature/setting/public/setting_feature_facade.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class Bootstrapper {
  static Future<MultiProvider> setup() async {
    Bootstrapper._init();

    final currencyFeatureFacade = CurrencyFeatureFacade();
    await currencyFeatureFacade.populateIfNeeded();

    final settingModelManager = SettingModelManager(currencyFeatureFacade);
    final settingModel = await SettingModel(settingModelManager).init();

    final aboutFeatureFacade = AboutFeatureFacade();
    final conversionFeatureFacade = ConversionFeatureFacade();
    final historyFeatureFacade = HistoryFeatureFacade();
    final settingFeatureFacade = SettingFeatureFacade();

    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => settingModel),
      Provider(create: (_) => aboutFeatureFacade),
      Provider(create: (_) => conversionFeatureFacade),
      Provider(create: (_) => currencyFeatureFacade),
      Provider(create: (_) => historyFeatureFacade),
      Provider(create: (_) => settingFeatureFacade),
    ], child: const FrontMaterialApp());
  }

  static Future<void> _init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }
}
