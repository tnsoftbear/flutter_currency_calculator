import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/internal/selection/currency_selection_corrector.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';

final class CurrencyVisibilityUpdater {
  CurrencyVisibilityUpdater(
      this._currencyRepository, this._currencySelectionCorrector);

  final CurrencySelectionCorrector _currencySelectionCorrector;
  final CurrencyRepository _currencyRepository;

  Future<Currency?> changeVisibleSourceCurrency(
      Currency currency, bool? isVisible, SettingModel settingModel) async {
    isVisible ??= false;
    if (isVisible) {
      currency.isVisibleForSource = true;
      await _currencyRepository.save(currency);
    } else {
      // Reject to remove last currency.
      if (await _currencyRepository.countVisibleSourceCurrencies() == 1) {
        return null;
      }

      currency.isVisibleForSource = false;
      await _currencyRepository.save(currency);
    }

    settingModel.updateVisibleSourceCurrencyCodes(
        await _currencyRepository.loadVisibleSourceCurrencyCodes());
    await _currencySelectionCorrector.correctSelectedSourceCurrency(currency, settingModel);
    return currency;
  }

  Future<Currency?> changeVisibleTargetCurrency(
      Currency currency, bool? isVisible, SettingModel settingModel) async {
    isVisible ??= false;
    if (isVisible) {
      currency.isVisibleForTarget = true;
      await _currencyRepository.save(currency);
    } else {
      // Reject to remove last currency.
      if (await _currencyRepository.countVisibleTargetCurrencies() == 1) {
        return null;
      }

      currency.isVisibleForTarget = false;
      await _currencyRepository.save(currency);
    }

    settingModel.updateVisibleTargetCurrencyCodes(
        await _currencyRepository.loadVisibleTargetCurrencyCodes());
    await _currencySelectionCorrector.correctSelectedTargetCurrency(currency, settingModel);
    return currency;
  }
}
