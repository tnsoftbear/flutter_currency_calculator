import 'package:currency_calc/feature/currency/internal/app/update/currency_visibility_updater.dart';
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
    final currencyVisibilityUpdater =
        CurrencyVisibilityUpdater(widget.currencyRepository);
    final settingModel = context.read<SettingModel>();
    final key = widget.isSourceCurrency
        ? 'sourceCurrency_${_currency.code}'
        : 'targetCurrency_${_currency.code}';
    final onChange = widget.isSourceCurrency
        ? currencyVisibilityUpdater.changeVisibleSourceCurrency
        : currencyVisibilityUpdater.changeVisibleTargetCurrency;
    return Checkbox(
        key: Key(key),
        value: widget.isSourceCurrency
            ? _currency.isVisibleForSource
            : _currency.isVisibleForTarget,
        onChanged: (bool? visible) async {
          Currency? updatedCurrency =
              await onChange(_currency, visible, settingModel);
          if (updatedCurrency != null) {
            setState(() {
              _currency = updatedCurrency;
            });
          }
        });
  }
}
