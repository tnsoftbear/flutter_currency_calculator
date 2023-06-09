import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class CurrencyCheckbox extends HookWidget {
  CurrencyCheckbox(
      this._currency, this._isSourceCurrency, this._currencyVisibilityUpdater,
      {Key? key})
      : super(key: key);

  final Currency _currency;
  final bool _isSourceCurrency;
  final CurrencyVisibilityUpdater _currencyVisibilityUpdater;

  @override
  Widget build(BuildContext context) {
    final currencyNotifier = useState<Currency>(_currency);
    final settingModel = context.read<SettingModel>();
    final key = _isSourceCurrency
        ? 'sourceCurrency_${_currency.code}'
        : 'targetCurrency_${_currency.code}';
    final onChange = _isSourceCurrency
        ? _currencyVisibilityUpdater.changeVisibleSourceCurrency
        : _currencyVisibilityUpdater.changeVisibleTargetCurrency;

    return Checkbox(
      key: Key(key),
      value: _isSourceCurrency
          ? currencyNotifier.value.isVisibleForSource
          : currencyNotifier.value.isVisibleForTarget,
      onChanged: (bool? visible) async {
        Currency? updatedCurrency =
            await onChange(_currency.code, visible, settingModel);
        if (updatedCurrency != null) {
          currencyNotifier.value = updatedCurrency;
        }
      },
    );
  }
}
