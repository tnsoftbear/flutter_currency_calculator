import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/currency/internal/ui/setting/currency_checkbox.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'currency_checkbox_test.mocks.dart';

// flutter test .\test\widget\feature\currency\internal\ui\setting\currency_checkbox_test.dart
// https://github.com/tnsoftbear/flutter_currency_calculator/pull/new/tech/widget_tests

@GenerateNiceMocks([MockSpec<CurrencyVisibilityUpdater>()])
@GenerateNiceMocks([MockSpec<SettingModel>()])
void main() {
  group('CurrencyCheckbox', () {
    late MockSettingModel settingModel;
    late MockCurrencyVisibilityUpdater currencyVisibilityUpdater;

    setUp(() {
      settingModel = MockSettingModel();
      currencyVisibilityUpdater = MockCurrencyVisibilityUpdater();
    });

    testWidgets('Checkbox value changes correctly',
        (WidgetTester tester) async {
      final currency = Currency('USD', 'USA dollar', true, false);

      when(currencyVisibilityUpdater.changeVisibleSourceCurrency(
              'USD', false, any))
          .thenAnswer(
              (_) => Future.value(Currency('USD', 'USA dollar', false, false)));
      when(currencyVisibilityUpdater.changeVisibleSourceCurrency(
              'USD', true, any))
          .thenAnswer(
              (_) => Future.value(Currency('USD', 'USA dollar', true, false)));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<SettingModel>.value(value: settingModel),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: CurrencyCheckbox(
                currency,
                currency.isVisibleForSource,
                currencyVisibilityUpdater,
                key: Key('currency_checkbox'),
              ),
            ),
          ),
        ),
      );

      expect(find.byKey(Key('currency_checkbox')), findsOneWidget,
          reason: 'currency_checkbox found by key');
      expect(find.byType(Checkbox), findsOneWidget,
          reason: 'Single Checkbox widget');
      final checkboxFinder = find.byKey(Key('sourceCurrency_USD'));
      expect(checkboxFinder, findsOneWidget,
          reason: 'Single Checkbox widget found by key');
      final checkboxWidgetBefore =
          tester.firstWidget(checkboxFinder) as Checkbox;
      expect(checkboxWidgetBefore.value, true,
          reason: 'Checkbox value is initialized to be selected');

      await tester.tap(checkboxFinder);
      await tester.pump();

      // Note, it is another instance of Checkbox widget
      final checkboxWidgetAfter =
          tester.firstWidget(checkboxFinder) as Checkbox;
      expect(checkboxWidgetAfter.value, false,
          reason: 'Checkbox is not selected');

      await tester.tap(checkboxFinder);
      await tester.pump();

      final checkboxWidgetAfter2ndTap =
          tester.firstWidget(checkboxFinder) as Checkbox;
      expect(checkboxWidgetAfter2ndTap.value, true,
          reason: 'Checkbox is selected again');
    });
  });
}
