import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/could_not_load_currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/internal/selection/currency_selection_corrector.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';

final class CurrencyVisibilityUpdater {
  CurrencyVisibilityUpdater(
      this._currencyRepository, this._currencySelectionCorrector);

  final CurrencySelectionCorrector _currencySelectionCorrector;
  final CurrencyRepository _currencyRepository;

  Future<Currency?> changeVisibleSourceCurrency(
      String currencyCode, bool? isVisible, SettingModel settingModel) async {
    isVisible ??= false;
    Currency? initialCurrency =
        await _currencyRepository.loadByCode(currencyCode);
    if (initialCurrency == null) {
      throw CouldNotLoadCurrency.fromCode(currencyCode);
    }

    late final Currency updatedCurrency;
    if (isVisible) {
      updatedCurrency = initialCurrency.copyWith(isVisibleForSource: true);
      await _currencyRepository.save(updatedCurrency);
    } else {
      // Reject to remove last currency.
      if (await _currencyRepository.countVisibleSourceCurrencies() == 1) {
        return null;
      }

      updatedCurrency = initialCurrency.copyWith(isVisibleForSource: false);
      await _currencyRepository.save(updatedCurrency);
    }

    settingModel.updateVisibleSourceCurrencyCodes(
        await _currencyRepository.loadVisibleSourceCurrencyCodes());
    await _currencySelectionCorrector.correctSelectedSourceCurrency(
        updatedCurrency, settingModel);
    return updatedCurrency;
  }

  Future<Currency?> changeVisibleTargetCurrency(
      String currencyCode, bool? isVisible, SettingModel settingModel) async {
    isVisible ??= false;
    Currency? initialCurrency =
        await _currencyRepository.loadByCode(currencyCode);
    if (initialCurrency == null) {
      throw CouldNotLoadCurrency.fromCode(currencyCode);
    }

    late final Currency updatedCurrency;
    if (isVisible) {
      // currency.isVisibleForTarget = true;
      updatedCurrency = initialCurrency.copyWith(isVisibleForTarget: true);
      await _currencyRepository.save(updatedCurrency);
    } else {
      // Reject to remove last currency.
      if (await _currencyRepository.countVisibleTargetCurrencies() == 1) {
        return null;
      }

      // currency.isVisibleForTarget = false;
      updatedCurrency = initialCurrency.copyWith(isVisibleForTarget: false);
      await _currencyRepository.save(updatedCurrency);
    }

    settingModel.updateVisibleTargetCurrencyCodes(
        await _currencyRepository.loadVisibleTargetCurrencyCodes());
    await _currencySelectionCorrector.correctSelectedTargetCurrency(
        updatedCurrency, settingModel);
    return updatedCurrency;
  }
}
