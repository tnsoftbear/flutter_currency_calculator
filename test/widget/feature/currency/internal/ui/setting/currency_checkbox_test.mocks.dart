// Mocks generated by Mockito 5.4.0 from annotations
// in currency_calc/test/widget/feature/currency/internal/ui/setting/currency_checkbox_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i3;

import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart'
    as _i6;
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart'
    as _i4;
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeSettingModel_0 extends _i1.SmartFake implements _i2.SettingModel {
  _FakeSettingModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLocale_1 extends _i1.SmartFake implements _i3.Locale {
  _FakeLocale_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CurrencyVisibilityUpdater].
///
/// See the documentation for Mockito's code generation for more information.
class MockCurrencyVisibilityUpdater extends _i1.Mock
    implements _i4.CurrencyVisibilityUpdater {
  @override
  _i5.Future<_i6.Currency?> changeVisibleSourceCurrency(
    String? currencyCode,
    bool? isVisible,
    _i2.SettingModel? settingModel,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeVisibleSourceCurrency,
          [
            currencyCode,
            isVisible,
            settingModel,
          ],
        ),
        returnValue: _i5.Future<_i6.Currency?>.value(),
        returnValueForMissingStub: _i5.Future<_i6.Currency?>.value(),
      ) as _i5.Future<_i6.Currency?>);
  @override
  _i5.Future<_i6.Currency?> changeVisibleTargetCurrency(
    String? currencyCode,
    bool? isVisible,
    _i2.SettingModel? settingModel,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #changeVisibleTargetCurrency,
          [
            currencyCode,
            isVisible,
            settingModel,
          ],
        ),
        returnValue: _i5.Future<_i6.Currency?>.value(),
        returnValueForMissingStub: _i5.Future<_i6.Currency?>.value(),
      ) as _i5.Future<_i6.Currency?>);
}

/// A class which mocks [SettingModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockSettingModel extends _i1.Mock implements _i2.SettingModel {
  @override
  String get languageCode => (super.noSuchMethod(
        Invocation.getter(#languageCode),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get fontFamily => (super.noSuchMethod(
        Invocation.getter(#fontFamily),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get themeType => (super.noSuchMethod(
        Invocation.getter(#themeType),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get selectedSourceCurrencyCode => (super.noSuchMethod(
        Invocation.getter(#selectedSourceCurrencyCode),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  String get selectedTargetCurrencyCode => (super.noSuchMethod(
        Invocation.getter(#selectedTargetCurrencyCode),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  List<String> get visibleSourceCurrencyCodes => (super.noSuchMethod(
        Invocation.getter(#visibleSourceCurrencyCodes),
        returnValue: <String>[],
        returnValueForMissingStub: <String>[],
      ) as List<String>);
  @override
  List<String> get visibleTargetCurrencyCodes => (super.noSuchMethod(
        Invocation.getter(#visibleTargetCurrencyCodes),
        returnValue: <String>[],
        returnValueForMissingStub: <String>[],
      ) as List<String>);
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);
  @override
  _i5.Future<_i2.SettingModel> init() => (super.noSuchMethod(
        Invocation.method(
          #init,
          [],
        ),
        returnValue: _i5.Future<_i2.SettingModel>.value(_FakeSettingModel_0(
          this,
          Invocation.method(
            #init,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i2.SettingModel>.value(_FakeSettingModel_0(
          this,
          Invocation.method(
            #init,
            [],
          ),
        )),
      ) as _i5.Future<_i2.SettingModel>);
  @override
  void updateLanguageCode(String? languageCode) => super.noSuchMethod(
        Invocation.method(
          #updateLanguageCode,
          [languageCode],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i3.Locale detectLocale() => (super.noSuchMethod(
        Invocation.method(
          #detectLocale,
          [],
        ),
        returnValue: _FakeLocale_1(
          this,
          Invocation.method(
            #detectLocale,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeLocale_1(
          this,
          Invocation.method(
            #detectLocale,
            [],
          ),
        ),
      ) as _i3.Locale);
  @override
  void updateFontFamily(String? fontFamily) => super.noSuchMethod(
        Invocation.method(
          #updateFontFamily,
          [fontFamily],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void updateThemeType(String? themeType) => super.noSuchMethod(
        Invocation.method(
          #updateThemeType,
          [themeType],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void updateSelectedSourceCurrencyCode(String? currencyCode) =>
      super.noSuchMethod(
        Invocation.method(
          #updateSelectedSourceCurrencyCode,
          [currencyCode],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void updateSelectedTargetCurrencyCode(String? currencyCode) =>
      super.noSuchMethod(
        Invocation.method(
          #updateSelectedTargetCurrencyCode,
          [currencyCode],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void updateVisibleSourceCurrencyCodes(List<String>? currencyCodes) =>
      super.noSuchMethod(
        Invocation.method(
          #updateVisibleSourceCurrencyCodes,
          [currencyCodes],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void updateVisibleTargetCurrencyCodes(List<String>? currencyCodes) =>
      super.noSuchMethod(
        Invocation.method(
          #updateVisibleTargetCurrencyCodes,
          [currencyCodes],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i3.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i3.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
