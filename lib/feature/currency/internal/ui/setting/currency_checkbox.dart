import 'package:currency_calc/feature/currency/internal/app/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/setting/internal/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class CurrencyCheckbox extends HookWidget {
  const CurrencyCheckbox(
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
            ? _currency.isVisibleForSource
            : _currency.isVisibleForTarget,
        onChanged: (bool? visible) async {
          Currency? updatedCurrency =
          await onChange(_currency, visible, settingModel);
          if (updatedCurrency != null) {
            currencyNotifier.value = updatedCurrency.copyWith();
          }
        });
  }
}
