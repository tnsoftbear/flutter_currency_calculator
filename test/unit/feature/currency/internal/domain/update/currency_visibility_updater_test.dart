import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/internal/selection/currency_selection_corrector.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_visibility_updater_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CurrencyRepository>()])
@GenerateNiceMocks([MockSpec<SettingModel>()])
@GenerateNiceMocks([MockSpec<CurrencySelectionCorrector>()])
void main() {
  late CurrencyVisibilityUpdater sut;
  late MockCurrencyRepository currencyRepository;
  late MockCurrencySelectionCorrector currencySelectionCorrector;
  late MockSettingModel settingModel;

  setUp(() {
    currencyRepository = MockCurrencyRepository();
    currencySelectionCorrector = MockCurrencySelectionCorrector();
    settingModel = MockSettingModel();
    sut = CurrencyVisibilityUpdater(
      currencyRepository,
      currencySelectionCorrector,
    );
  });

  test('ChangeVisibleSourceCurrency - Make source currency visible', () async {
    // Arrange
    final updatingCurrency = Currency('USD', 'US Dollar', false, false);
    when(currencyRepository.save(updatingCurrency))
        .thenAnswer((_) => Future.value());
    when(currencyRepository.loadVisibleSourceCurrencyCodes())
        .thenAnswer((_) => Future.value(['USD', 'EUR']));
    when(currencySelectionCorrector.correctSelectedSourceCurrency(any, any))
        .thenAnswer((_) => Future.value());
    // Act
    final actualCurrency = await sut.changeVisibleSourceCurrency(
      updatingCurrency,
      true,
      settingModel,
    );
    // Assert
    expect(actualCurrency, equals(Currency('USD', 'US Dollar', true, false)));
  });

  test(
      'ChangeVisibleSourceCurrency - Make source currency hidden, when there are multiple visible currencies',
      () async {
    // Arrange
    final updatingCurrency = Currency('USD', 'US Dollar', true, false);
    when(currencyRepository.countVisibleSourceCurrencies())
        .thenAnswer((_) => Future.value(2));
    when(currencyRepository.save(updatingCurrency))
        .thenAnswer((_) => Future.value());
    when(currencyRepository.loadVisibleSourceCurrencyCodes())
        .thenAnswer((_) => Future.value(['EUR']));
    when(currencySelectionCorrector.correctSelectedSourceCurrency(any, any))
        .thenAnswer((_) => Future.value());
    // Act
    final actualCurrency = await sut.changeVisibleSourceCurrency(
      updatingCurrency,
      false,
      settingModel,
    );
    // Assert
    expect(actualCurrency, equals(Currency('USD', 'US Dollar', false, false)));
  });

  test(
      'ChangeVisibleSourceCurrency - Cannot make source currency hidden, when there is single visible currency',
      () async {
    // Arrange
    final updatingCurrency = Currency('USD', 'US Dollar', true, false);
    when(currencyRepository.countVisibleSourceCurrencies())
        .thenAnswer((_) => Future.value(1));
    // Act
    final actualCurrency = await sut.changeVisibleSourceCurrency(
      updatingCurrency,
      false,
      settingModel,
    );
    // Assert
    expect(actualCurrency, isNull);
    expect(updatingCurrency.isVisibleForSource, isTrue);
    verifyNever(currencyRepository.save(updatingCurrency));
  });

  // --- Test changing for the Target Currency ---

  test('ChangeVisibleTargetCurrency - Make target currency visible', () async {
    // Arrange
    final updatingCurrency = Currency('USD', 'US Dollar', false, false);
    when(currencyRepository.save(updatingCurrency))
        .thenAnswer((_) => Future.value());
    when(currencyRepository.loadVisibleTargetCurrencyCodes())
        .thenAnswer((_) => Future.value(['USD', 'EUR']));
    when(currencySelectionCorrector.correctSelectedTargetCurrency(any, any))
        .thenAnswer((_) => Future.value());
    // Act
    final actualCurrency = await sut.changeVisibleTargetCurrency(
      updatingCurrency,
      true,
      settingModel,
    );
    // Assert
    expect(actualCurrency, equals(Currency('USD', 'US Dollar', false, true)));
  });

  test(
      'ChangeVisibleTargetCurrency - Make target currency hidden, when there are multiple visible currencies',
      () async {
    // Arrange
    final updatingCurrency = Currency('USD', 'US Dollar', false, true);
    when(currencyRepository.countVisibleTargetCurrencies())
        .thenAnswer((_) => Future.value(2));
    when(currencyRepository.save(updatingCurrency))
        .thenAnswer((_) => Future.value());
    when(currencyRepository.loadVisibleTargetCurrencyCodes())
        .thenAnswer((_) => Future.value(['EUR']));
    when(currencySelectionCorrector.correctSelectedTargetCurrency(any, any))
        .thenAnswer((_) => Future.value());
    // Act
    final actualCurrency = await sut.changeVisibleTargetCurrency(
      updatingCurrency,
      false,
      settingModel,
    );
    // Assert
    expect(actualCurrency, equals(Currency('USD', 'US Dollar', false, false)));
  });

  test(
      'ChangeVisibleTargetCurrency - Cannot make target currency hidden, when there is single visible currency',
      () async {
    // Arrange
    final updatingCurrency = Currency('USD', 'US Dollar', false, true);
    when(currencyRepository.countVisibleTargetCurrencies())
        .thenAnswer((_) => Future.value(1));
    // Act
    final actualCurrency = await sut.changeVisibleTargetCurrency(
      updatingCurrency,
      false,
      settingModel,
    );
    // Assert
    expect(actualCurrency, isNull);
    expect(updatingCurrency.isVisibleForTarget, isTrue);
    verifyNever(currencyRepository.save(updatingCurrency));
  });
}
