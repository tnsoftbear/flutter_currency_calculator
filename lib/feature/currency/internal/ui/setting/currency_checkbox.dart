import 'dart:developer';

import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyCheckbox extends StatefulWidget {
  const CurrencyCheckbox(
      this.currency, this.isSourceCurrency, this.currencyRepository,
      {Key? key})
      : super(key: key);

  final Currency currency;
  final bool isSourceCurrency;
  final CurrencyRepository currencyRepository;

  @override
  _CurrencyCheckboxState createState() => _CurrencyCheckboxState();
}

class _CurrencyCheckboxState extends State<CurrencyCheckbox> {
  late Currency _currency;

  @override
  void initState() {
    super.initState();
    _currency = widget.currency;
  }

  @override
  Widget build(BuildContext context) {
    final key = widget.isSourceCurrency
        ? 'sourceCurrency_${_currency.code}'
        : 'targetCurrency_${_currency.code}';
    final onChanged = widget.isSourceCurrency
        ? _onChangedVisibleSourceCurrency
        : _onChangedVisibleTargetCurrency;
    return Checkbox(
        key: Key(key),
        value: widget.isSourceCurrency
            ? _currency.isVisibleForSource
            : _currency.isVisibleForTarget,
        onChanged: (bool? visible) => onChanged(_currency, visible, context));
  }

  Future<void> _onChangedVisibleSourceCurrency(
      Currency updatingCurrency, bool? visible, BuildContext context) async {
    visible ??= false;
    final settingModel = context.read<SettingModel>();

    if (visible) {
      updatingCurrency.isVisibleForSource = true;
      await widget.currencyRepository.save(updatingCurrency);
    } else {
      // Reject to remove last currency.
      if (await widget.currencyRepository.countVisibleSourceCurrencies() == 1) {
        return;
      }

      updatingCurrency.isVisibleForSource = false;
      await widget.currencyRepository.save(updatingCurrency);
    }

    settingModel.setVisibleSourceCurrencyCodes(
        await widget.currencyRepository.loadVisibleSourceCurrencyCodes());

    setState(() {
      _currency = updatingCurrency;
    });

    await _correctSelectedSourceCurrency();
  }

  Future<void> _correctSelectedSourceCurrency() async {
    final settingModel = context.read<SettingModel>();

    // Replace selected source currency, if it is absent in drop-down list
    final selectedSourceCurrency = await widget.currencyRepository
        .loadByCode(settingModel.selectedSourceCurrencyCode);
    if (!selectedSourceCurrency!.isVisibleForSource) {
      final visibleSourceCurrencies =
          await widget.currencyRepository.loadVisibleSourceCurrencies();
      String newSelectedSourceCurrencyCode = "";
      if (await widget.currencyRepository.countVisibleSourceCurrencies() > 1 &&
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
        settingModel.setSourceCurrencyCode(newSelectedSourceCurrencyCode);
        log('Selected source currency is changed from ${_currency.code} to $newSelectedSourceCurrencyCode (target is ${settingModel.selectedTargetCurrencyCode})');
      }
    }
  }

  Future<void> _onChangedVisibleTargetCurrency(
      Currency updatingCurrency, bool? visible, BuildContext context) async {
    visible ??= false;
    final settingModel = context.read<SettingModel>();

    if (visible) {
      updatingCurrency.isVisibleForTarget = true;
      await widget.currencyRepository.save(updatingCurrency);
    } else {
      // Reject to remove last currency.
      if (await widget.currencyRepository.countVisibleTargetCurrencies() == 1) {
        return;
      }

      updatingCurrency.isVisibleForTarget = false;
      await widget.currencyRepository.save(updatingCurrency);
    }

    settingModel.setVisibleTargetCurrencyCodes(
        await widget.currencyRepository.loadVisibleTargetCurrencyCodes());

    setState(() {
      _currency = updatingCurrency;
    });

    await _correctSelectedTargetCurrency();
  }

  Future<void> _correctSelectedTargetCurrency() async {
    final settingModel = context.read<SettingModel>();

    // Replace selected target currency, if it is absent in drop-down list
    final selectedTargetCurrency = await widget.currencyRepository
        .loadByCode(settingModel.selectedTargetCurrencyCode);
    if (!selectedTargetCurrency!.isVisibleForTarget) {
      final visibleTargetCurrencies =
          await widget.currencyRepository.loadVisibleTargetCurrencies();
      String newSelectedTargetCurrencyCode = "";
      if (await widget.currencyRepository.countVisibleTargetCurrencies() > 1 &&
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
        settingModel.setTargetCurrencyCode(newSelectedTargetCurrencyCode);
        log('Selected target currency is changed from ${_currency.code} to $newSelectedTargetCurrencyCode (source is ${settingModel.selectedSourceCurrencyCode})');
      }
    }
  }
}
