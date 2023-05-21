import 'package:currency_calc/feature/setting/internal/domain/model/setting_model.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'setting_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SettingModelManager>()])
void main() {
  group('SettingModel', () {
    late SettingModel sut;
    late MockSettingModelManager settingModelManager;

    setUp(() {
      settingModelManager = MockSettingModelManager();
      sut = SettingModel(settingModelManager);
    });

    test('init should initialize the model with correct values', () async {
      // Arrange
      final languageCode = 'en';
      final fontFamily = 'Roboto';
      final themeType = 'dark';
      final selectedSourceCurrencyCode = 'USD';
      final selectedTargetCurrencyCode = 'EUR';
      final visibleSourceCurrencyCodes = ['USD', 'EUR', 'GBP'];
      final visibleTargetCurrencyCodes = ['EUR', 'GBP'];

      when(settingModelManager.detectLanguageCode())
          .thenAnswer((_) async => languageCode);
      when(settingModelManager.detectFontFamily())
          .thenAnswer((_) async => fontFamily);
      when(settingModelManager.detectThemeType())
          .thenAnswer((_) async => themeType);
      when(settingModelManager.detectSelectedSourceCurrencyCode())
          .thenAnswer((_) async => selectedSourceCurrencyCode);
      when(settingModelManager.detectSelectedTargetCurrencyCode(any))
          .thenAnswer((_) async => selectedTargetCurrencyCode);
      when(settingModelManager.detectVisibleSourceCurrencyCodes())
          .thenAnswer((_) async => visibleSourceCurrencyCodes);
      when(settingModelManager.detectVisibleTargetCurrencyCodes())
          .thenAnswer((_) async => visibleTargetCurrencyCodes);

      // Act
      final result = await sut.init();

      // Assert
      expect(result.languageCode, equals(languageCode));
      expect(result.fontFamily, equals(fontFamily));
      expect(result.themeType, equals(themeType));
      expect(result.selectedSourceCurrencyCode,
          equals(selectedSourceCurrencyCode));
      expect(result.selectedTargetCurrencyCode,
          equals(selectedTargetCurrencyCode));
      expect(result.visibleSourceCurrencyCodes,
          equals(visibleSourceCurrencyCodes));
      expect(result.visibleTargetCurrencyCodes,
          equals(visibleTargetCurrencyCodes));
    });

    test(
        'updateLanguageCode should update the language code',
        () {
      // Arrange
      final languageCode = 'en';
      // Act
      sut.updateLanguageCode(languageCode);
      // Assert
      expect(sut.languageCode, equals(languageCode));
      verify(settingModelManager.saveLanguageCode(languageCode)).called(1);
    });

    test('updateFontFamily should update the font family', () {
      // Arrange
      final fontFamily = 'Roboto';

      // Act
      sut.updateFontFamily(fontFamily);

      // Assert
      expect(sut.fontFamily, equals(fontFamily));
      verify(settingModelManager.saveFontFamily(fontFamily)).called(1);
    });

    test('updateThemeType should update the theme type', () {
      // Arrange
      final themeType = 'dark';

      // Act
      sut.updateThemeType(themeType);

      // Assert
      expect(sut.themeType, equals(themeType));
      verify(settingModelManager.saveThemeType(themeType)).called(1);
    });

    test('updateSelectedSourceCurrencyCode should update the selected source currency code', () {
      // Arrange
      final currencyCode = 'USD';

      // Act
      sut.updateSelectedSourceCurrencyCode(currencyCode);

      // Assert
      expect(sut.selectedSourceCurrencyCode, equals(currencyCode));
      verify(settingModelManager.saveDefaultSourceCurrencyCode(currencyCode)).called(1);
    });

    test('updateSelectedTargetCurrencyCode should update the selected target currency code', () {
      // Arrange
      final currencyCode = 'EUR';

      // Act
      sut.updateSelectedTargetCurrencyCode(currencyCode);

      // Assert
      expect(sut.selectedTargetCurrencyCode, equals(currencyCode));
      verify(settingModelManager.saveDefaultTargetCurrencyCode(currencyCode)).called(1);
    });

    test('updateVisibleSourceCurrencyCodes should update the visible source currency codes', () {
      // Arrange
      final currencyCodes = ['USD', 'EUR', 'GBP'];

      // Act
      sut.updateVisibleSourceCurrencyCodes(currencyCodes);

      // Assert
      expect(sut.visibleSourceCurrencyCodes, equals(currencyCodes));
      verify(settingModelManager.saveVisibleSourceCurrencyCodes(currencyCodes)).called(1);
    });

    test('updateVisibleTargetCurrencyCodes should update the visible target currency codes', () {
      // Arrange
      final currencyCodes = ['EUR', 'GBP'];

      // Act
      sut.updateVisibleTargetCurrencyCodes(currencyCodes);

      // Assert
      expect(sut.visibleTargetCurrencyCodes, equals(currencyCodes));
      verify(settingModelManager.saveVisibleTargetCurrencyCodes(currencyCodes)).called(1);
    });
  });
}
