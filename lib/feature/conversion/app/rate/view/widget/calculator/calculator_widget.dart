import 'dart:developer';
import 'package:currency_calc/feature/conversion/app/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/app/history/model/last_history_model.dart';
import 'package:currency_calc/feature/conversion/app/rate/fetch/rate_fetcher_factory.dart';
import 'package:currency_calc/feature/conversion/app/rate/translate/conversion_validation_translator.dart';
import 'package:currency_calc/feature/conversion/domain/history/model/conversion_history_record.dart';
import 'package:currency_calc/feature/conversion/domain/rate/calculate/currency_converter.dart';
import 'package:currency_calc/feature/conversion/domain/rate/validate/conversion_validator.dart';
import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/front/app/view/theme/additional_colors.dart';
import 'package:currency_calc/feature/setting/app/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/all_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  late bool _isLoading;
  late bool _areActionButtonsVisible;
  late double _rate;
  late double _sourceAmount;
  late double _targetAmount;
  late String _rateMessage;
  late String _resultMessage;
  late String _sourceAmountInput;
  late String _sourceCurrency;
  late String _targetCurrency;
  late CurrencyFeatureFacade _currencyFeatureFacade;

  final _sourceAmountController = TextEditingController();
  final _sourceAmountTextFieldFocusNode = FocusNode();

  @override
  void initState() {
    _isLoading = false;
    _areActionButtonsVisible = false;
    _rate = 0.0;
    _rateMessage = '';
    _resultMessage = '';
    _sourceAmount = 0.0;
    _sourceAmountInput = '';
    _targetAmount = 0.0;
    final settingModel = context.read<SettingModel>();
    _sourceCurrency = settingModel.selectedSourceCurrencyCode;
    _targetCurrency = settingModel.selectedTargetCurrencyCode;
    _currencyFeatureFacade = context.read<CurrencyFeatureFacade>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context);
    final AdditionalColors additionalColors =
        Theme.of(context).extension<AdditionalColors>()!;
    final settingModel = context.watch<SettingModel>();
    if (!settingModel.visibleSourceCurrencyCodes.contains(_sourceCurrency)) {
      _sourceCurrency = settingModel.selectedSourceCurrencyCode;
    }
    if (!settingModel.visibleTargetCurrencyCodes.contains(_targetCurrency)) {
      _targetCurrency = settingModel.selectedTargetCurrencyCode;
    }
    return Padding(
      key: ValueKey("currencyConversionCalculatorWidget"),
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: additionalColors.linenLucidColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              DropdownButton<String>(
                value: _sourceCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _sourceCurrency = newValue!;
                  });
                  _updateConversion();
                },
                items: settingModel.visibleSourceCurrencyCodes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: _targetCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    _targetCurrency = newValue!;
                  });
                  _updateConversion();
                },
                items: settingModel.visibleTargetCurrencyCodes
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ]),
            Container(
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: additionalColors.linenLucidColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  key: Key('sourceAmount'),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  autofocus: true,
                  focusNode: _sourceAmountTextFieldFocusNode,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _sourceAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    labelText: tr.conversionEnterAmount,
                  ),
                  onChanged: (text) {
                    setState(() {
                      _sourceAmountInput = text;
                      _updateConversion();
                    });
                  },
                )),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: _isLoading
                  ? Center(child: const CircularProgressIndicator())
                  : Column(
                      children: [
                        Text(
                          _resultMessage,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _rateMessage,
                          style: const TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Visibility(
                          visible: _areActionButtonsVisible,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                  key: Key('saveCurrencyConversionButton'),
                                  onPressed: _onSavePressed,
                                  child: Text(tr.conversionSaveButtonText)),
                              ElevatedButton(
                                  key: Key('cancelCurrencyConversionButton'),
                                  onPressed: _onCancelPressed,
                                  child: Text(tr.conversionCancelButtonText))
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateConversion() async {
    if (_sourceAmountInput.isEmpty) {
      return;
    }

    final tr = AppLocalizations.of(context);
    final validationResult = ConversionValidator.validate(
        sourceCurrency: _sourceCurrency,
        targetCurrency: _targetCurrency,
        amount: _sourceAmountInput,
        visibleSourceCurrencyCodes:
            await _currencyFeatureFacade.loadVisibleSourceCurrencyCodes(),
        visibleTargetCurrencyCodes:
            await _currencyFeatureFacade.loadVisibleTargetCurrencyCodes());
    if (!validationResult.isSuccess()) {
      setState(() {
        _resultMessage =
            ConversionValidationTranslator.translateConcatenatedErrorMessage(
                context: context, validationResult: validationResult);
        _rateMessage = '';
        _areActionButtonsVisible = false;
      });
      return;
    }

    final settingModel = context.read<SettingModel>();
    settingModel.setSourceCurrencyCode(_sourceCurrency);
    settingModel.setTargetCurrencyCode(_targetCurrency);

    setState(() {
      _isLoading = true;
    });

    final rateFetcher = RateFetcherFactory.create(ConversionConfig());
    rateFetcher
        .fetchExchangeRate(_sourceCurrency, _targetCurrency)
        .then((rate) {
      final localeName = Localizations.localeOf(context).toString();
      final currencyFormatter = NumberFormat.simpleCurrency(
          locale: localeName, name: _targetCurrency);
      final numberFormatter = NumberFormat.decimalPattern(localeName);
      setState(() {
        _rate = rate;
        _sourceAmount = double.parse(_sourceAmountInput);
        _targetAmount = CurrencyConverter.convert(_sourceAmount, rate);
        _resultMessage = tr.conversionCalculationResult(
            currencyFormatter.format(_targetAmount));
        final rateFormatted = numberFormatter.format(_rate);
        _rateMessage = tr.conversionRateResult(
            rateFormatted, _sourceCurrency, _targetCurrency);
        _isLoading = false;
        _areActionButtonsVisible = true;
      });
    }).catchError((error) {
      setState(() {
        _resultMessage = error.toString();
        _isLoading = false;
        _areActionButtonsVisible = false;
      });
    });
  }

  void _onSavePressed() async {
    var historyRecord = ConversionHistoryRecord()
      ..sourceCurrency = _sourceCurrency
      ..targetCurrency = _targetCurrency
      ..sourceAmount = _sourceAmount
      ..targetAmount = _targetAmount
      ..rate = _rate
      ..date = DateTime.now();
    context.read<LastHistoryModel>().addRecord(historyRecord);
    FocusScope.of(context).requestFocus(_sourceAmountTextFieldFocusNode);
    _resetInputs();
    log(
        'Saved currency conversion record (Source: $_sourceCurrency $_sourceAmount, ' +
            'Target: $_targetCurrency $_targetAmount, Rate: $_rate)',
        time: DateTime.now(),
        name: 'CurrencyConversionScreen');
  }

  void _onCancelPressed() {
    FocusScope.of(context).requestFocus(_sourceAmountTextFieldFocusNode);
    _resetInputs();
  }

  void _resetInputs() {
    setState(() {
      _areActionButtonsVisible = false;
      _rateMessage = '';
      _resultMessage = '';
      _sourceAmountController.clear();
      _sourceAmountInput = '';
    });
  }
}
