import 'dart:developer';

import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';

class CurrencySelectionCorrector {
  CurrencySelectionCorrector(this._currencyRepository);

  final CurrencyRepository _currencyRepository;

  Future<void> correctSelectedSourceCurrency(
      Currency currency, SettingModel settingModel) async {
    // Replace selected source currency, if it is absent in drop-down list
    final selectedSourceCurrency = await _currencyRepository
        .loadByCode(settingModel.selectedSourceCurrencyCode);
    if (!selectedSourceCurrency!.isVisibleForSource) {
      final visibleSourceCurrencies =
          await _currencyRepository.loadVisibleSourceCurrencies();
      String newSelectedSourceCurrencyCode = "";
      if (await _currencyRepository.countVisibleSourceCurrencies() > 1 &&
          settingModel.selectedTargetCurrencyCode ==
              visibleSourceCurrencies.first.code) {
        // Replace with the second currency from the visible currency list,
        // because the first currency is already selected as target currency.
        newSelectedSourceCurrencyCode = visibleSourceCurrencies[1].code;
      } else {
        // Replace with the first currency in the visible currency list
        newSelectedSourceCurrencyCode = visibleSourceCurrencies.first.code;
      }

      if (newSelectedSourceCurrencyCode != "") {
        settingModel
            .updateSelectedSourceCurrencyCode(newSelectedSourceCurrencyCode);
        log('Selected source currency is changed from ${currency.code}' +
            ' to $newSelectedSourceCurrencyCode (target is ${settingModel.selectedTargetCurrencyCode})');
      }
    }
  }

  Future<void> correctSelectedTargetCurrency(
      Currency currency, SettingModel settingModel) async {
    // Replace selected target currency, if it is absent in drop-down list
    final selectedTargetCurrency = await _currencyRepository
        .loadByCode(settingModel.selectedTargetCurrencyCode);
    if (!selectedTargetCurrency!.isVisibleForTarget) {
      final visibleTargetCurrencies =
          await _currencyRepository.loadVisibleTargetCurrencies();
      String newSelectedTargetCurrencyCode = "";
      if (await _currencyRepository.countVisibleTargetCurrencies() > 1 &&
          settingModel.selectedSourceCurrencyCode ==
              visibleTargetCurrencies.first.code) {
        // Replace with the second currency in the visible currency list,
        // because the first currency is already selected as source currency.
        newSelectedTargetCurrencyCode = visibleTargetCurrencies[1].code;
      } else {
        // Replace with the first currency in the visible currency list
        newSelectedTargetCurrencyCode = visibleTargetCurrencies.first.code;
      }

      if (newSelectedTargetCurrencyCode != "") {
        settingModel
            .updateSelectedTargetCurrencyCode(newSelectedTargetCurrencyCode);
        log('Selected target currency is changed from ${currency.code} ' +
            ' to $newSelectedTargetCurrencyCode (source is ${settingModel.selectedSourceCurrencyCode})');
      }
    }
  }
}
