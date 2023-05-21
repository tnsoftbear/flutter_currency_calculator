import 'package:currency_calc/feature/currency/internal/domain/update/internal/selection/currency_selection_corrector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'currency_selection_corrector_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CurrencyRepository>()])
@GenerateNiceMocks([MockSpec<SettingModel>()])
void main() {
  late CurrencySelectionCorrector sut;
  late MockCurrencyRepository currencyRepository;
  late MockSettingModel settingModel;

  setUp(() {
    currencyRepository = MockCurrencyRepository();
    settingModel = MockSettingModel();
    sut = CurrencySelectionCorrector(currencyRepository);
  });

  test(
      'correctSelectedSourceCurrency should update selected source currency USD to RUB,' +
          ' because USD currency is not visible and EUR currency is selected for target currency',
      () async {
    // Arrange
    final selectedSourceCurrency = Currency('USD', 'US Dollar', false, true);
    final visibleSourceCurrencies = [
      Currency('EUR', 'Euro', true, true),
      Currency('RUB', 'Russian Ruble', true, true),
    ];
    final selectedSourceCurrencyCode = 'USD';
    final selectedTargetCurrencyCode = 'EUR';

    when(settingModel.selectedSourceCurrencyCode)
        .thenReturn(selectedSourceCurrencyCode);
    when(settingModel.selectedTargetCurrencyCode)
        .thenReturn(selectedTargetCurrencyCode);
    when(currencyRepository.loadByCode(selectedSourceCurrencyCode))
        .thenAnswer((_) => Future.value(selectedSourceCurrency));
    when(currencyRepository.loadVisibleSourceCurrencies())
        .thenAnswer((_) => Future.value(visibleSourceCurrencies));
    when(currencyRepository.countVisibleSourceCurrencies())
        .thenAnswer((_) => Future.value(2));

    // Act
    await sut.correctSelectedSourceCurrency(
        selectedSourceCurrency, settingModel);

    // Assert
    verify(settingModel.updateSelectedSourceCurrencyCode('RUB')).called(1);
  });

  test(
      'correctSelectedSourceCurrency should update selected source currency USD to EUR,' +
          ' because USD currency is not visible and EUR currency is the first in the visible currency list',
      () async {
    // Arrange
    final selectedSourceCurrency = Currency('USD', 'US Dollar', false, true);
    final visibleSourceCurrencies = [
      Currency('EUR', 'Euro', true, true),
      Currency('RUB', 'Russian Ruble', true, true),
    ];
    final selectedSourceCurrencyCode = 'USD';
    final selectedTargetCurrencyCode = 'GBP';

    when(settingModel.selectedSourceCurrencyCode)
        .thenReturn(selectedSourceCurrencyCode);
    when(settingModel.selectedTargetCurrencyCode)
        .thenReturn(selectedTargetCurrencyCode);
    when(currencyRepository.loadByCode(selectedSourceCurrencyCode))
        .thenAnswer((_) => Future.value(selectedSourceCurrency));
    when(currencyRepository.loadVisibleSourceCurrencies())
        .thenAnswer((_) => Future.value(visibleSourceCurrencies));
    when(currencyRepository.countVisibleSourceCurrencies())
        .thenAnswer((_) => Future.value(2));

    // Act
    await sut.correctSelectedSourceCurrency(
        selectedSourceCurrency, settingModel);

    // Assert
    verify(settingModel.updateSelectedSourceCurrencyCode('EUR')).called(1);
  });

  test(
      'correctSelectedSourceCurrency should not update selected source currency USD,' +
          ' because USD currency is already visible for source currency',
      () async {
    // Arrange
    final selectedSourceCurrency = Currency('USD', 'US Dollar', true, true);
    final selectedSourceCurrencyCode = 'USD';

    when(settingModel.selectedSourceCurrencyCode)
        .thenReturn(selectedSourceCurrencyCode);
    when(currencyRepository.loadByCode(selectedSourceCurrencyCode))
        .thenAnswer((_) => Future.value(selectedSourceCurrency));

    // Act
    await sut.correctSelectedSourceCurrency(
        selectedSourceCurrency, settingModel);

    // Assert
    verifyNever(settingModel.updateSelectedSourceCurrencyCode(any));
  });

  // tests for target currency

  test(
    'correctSelectedTargetCurrency should update selected target currency USD to RUB,' +
        ' because USD currency is not visible and EUR currency is selected for source currency',
        () async {
      // Arrange
      final selectedTargetCurrency = Currency('USD', 'US Dollar', true, false);
      final visibleTargetCurrencies = [
        Currency('EUR', 'Euro', true, true),
        Currency('RUB', 'Russian Ruble', true, true),
      ];
      final selectedSourceCurrencyCode = 'EUR';
      final selectedTargetCurrencyCode = 'USD';

      when(settingModel.selectedSourceCurrencyCode)
          .thenReturn(selectedSourceCurrencyCode);
      when(settingModel.selectedTargetCurrencyCode)
          .thenReturn(selectedTargetCurrencyCode);
      when(currencyRepository.loadByCode(selectedTargetCurrencyCode))
          .thenAnswer((_) => Future.value(selectedTargetCurrency));
      when(currencyRepository.loadVisibleTargetCurrencies())
          .thenAnswer((_) => Future.value(visibleTargetCurrencies));
      when(currencyRepository.countVisibleTargetCurrencies())
          .thenAnswer((_) => Future.value(2));

      // Act
      await sut.correctSelectedTargetCurrency(
        selectedTargetCurrency,
        settingModel,
      );

      // Assert
      verify(settingModel.updateSelectedTargetCurrencyCode('RUB')).called(1);
    },
  );

  test(
    'correctSelectedTargetCurrency should update selected target currency GBP to EUR,' +
        ' because GBP currency is not visible and EUR currency is the first in the visible currency list',
        () async {
      // Arrange
      final selectedTargetCurrency = Currency('GBP', 'British Pound', true, false);
      final visibleTargetCurrencies = [
        Currency('EUR', 'Euro', true, true),
        Currency('USD', 'US Dollar', true, true),
      ];
      final selectedSourceCurrencyCode = 'USD';
      final selectedTargetCurrencyCode = 'GBP';

      when(settingModel.selectedSourceCurrencyCode)
          .thenReturn(selectedSourceCurrencyCode);
      when(settingModel.selectedTargetCurrencyCode)
          .thenReturn(selectedTargetCurrencyCode);
      when(currencyRepository.loadByCode(selectedTargetCurrencyCode))
          .thenAnswer((_) => Future.value(selectedTargetCurrency));
      when(currencyRepository.loadVisibleTargetCurrencies())
          .thenAnswer((_) => Future.value(visibleTargetCurrencies));
      when(currencyRepository.countVisibleTargetCurrencies())
          .thenAnswer((_) => Future.value(2));

      // Act
      await sut.correctSelectedTargetCurrency(
        selectedTargetCurrency,
        settingModel,
      );

      // Assert
      verify(settingModel.updateSelectedTargetCurrencyCode('EUR')).called(1);
    },
  );

  test(
    'correctSelectedTargetCurrency should not update selected target currency GBP,' +
        ' because GBP currency is already visible for target currency',
        () async {
      // Arrange
      final selectedTargetCurrency = Currency('GBP', 'British Pound', true, true);
      final selectedTargetCurrencyCode = 'GBP';

      when(settingModel.selectedTargetCurrencyCode)
          .thenReturn(selectedTargetCurrencyCode);
      when(currencyRepository.loadByCode(selectedTargetCurrencyCode))
          .thenAnswer((_) => Future.value(selectedTargetCurrency));

      // Act
      await sut.correctSelectedTargetCurrency(
        selectedTargetCurrency,
        settingModel,
      );

      // Assert
      verifyNever(settingModel.updateSelectedTargetCurrencyCode(any));
    },
  );

}
