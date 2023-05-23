import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CurrencyCheckbox extends StatefulWidget {
  const CurrencyCheckbox(
      this._currency, this._isSourceCurrency, this._currencyVisibilityUpdater,
      {Key? key})
      : super(key: key);

  final Currency _currency;
  final bool _isSourceCurrency;
  final CurrencyVisibilityUpdater _currencyVisibilityUpdater;

  @override
  _CurrencyCheckboxState createState() => _CurrencyCheckboxState();
}

class _CurrencyCheckboxState extends State<CurrencyCheckbox> {
  late Currency _currency;

  @override
  void initState() {
    super.initState();
    _currency = widget._currency;
  }

  @override
  Widget build(BuildContext context) {
    final settingModel = context.read<SettingModel>();
    final key = widget._isSourceCurrency
        ? 'sourceCurrency_${_currency.code}'
        : 'targetCurrency_${_currency.code}';
    final onChange = widget._isSourceCurrency
        ? widget._currencyVisibilityUpdater.changeVisibleSourceCurrency
        : widget._currencyVisibilityUpdater.changeVisibleTargetCurrency;

    return Checkbox(
      key: Key(key),
      value: widget._isSourceCurrency
          ? _currency.isVisibleForSource
          : _currency.isVisibleForTarget,
      onChanged: (bool? visible) async {
        Currency? updatedCurrency =
            await onChange(_currency.code, visible, settingModel);
        if (updatedCurrency != null) {
          setState(() {
            _currency = updatedCurrency;
          });
        }
      },
    );
  }
}
