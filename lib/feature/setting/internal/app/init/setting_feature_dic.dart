import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model_manager.dart';
import 'package:currency_calc/feature/setting/internal/domain/repository/setting_repository_impl.dart';
import 'package:currency_calc/feature/setting/internal/infra/data_source/setting_shared_prefs_data_source.dart';

final class SettingFeatureDic {
  SettingFeatureDic();

  Future<void> initSettingModel(
      CurrencyFeatureFacade currencyFeatureFacade) async {
    final settingRepository =
        SettingRepositoryImpl(SettingSharedPrefsDataSource());
    final settingModelManager =
        SettingModelManager(settingRepository, currencyFeatureFacade);
    _settingModel = await SettingModel(settingModelManager).init();
  }

  late final SettingModel _settingModel;

  SettingModel get settingModel => _settingModel;
}
