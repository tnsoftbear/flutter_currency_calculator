import 'package:currency_calc/feature/currency/public/currency_feature_facade.dart';
import 'package:currency_calc/feature/setting/internal/domain/model/setting_model_manager.dart';
import 'package:currency_calc/front/app/constant/appearance_constant.dart';
import 'package:currency_calc/feature/setting/internal/domain/repository/setting_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'setting_model_manager_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SettingRepository>()])
@GenerateNiceMocks([MockSpec<CurrencyFeatureFacade>()])
void main() {
  late SettingModelManager sut;
  late MockSettingRepository settingRepository;
  late MockCurrencyFeatureFacade currencyFeatureFacade;

  setUp(() {
    settingRepository = MockSettingRepository();
    currencyFeatureFacade = MockCurrencyFeatureFacade();
    sut = SettingModelManager(
      settingRepository,
      currencyFeatureFacade,
    );
  });

  test('detectLanguageCode should return the saved language code if available',
          () async {
        // Arrange
        final savedLanguageCode = 'en';
        when(settingRepository.loadString('languageCode'))
            .thenAnswer((_) => Future.value(savedLanguageCode));
        // Act
        final result = await sut.detectLanguageCode();
        // Assert
        expect(result, equals(savedLanguageCode));
      });

  test(
      'detectLanguageCode should return the default language code if not saved',
          () async {
        // Arrange
        when(settingRepository.loadString('languageCode'))
            .thenAnswer((_) => Future.value(null));
        // Act
        final result = await sut.detectLanguageCode();
        // Assert
        expect(result, equals(AppearanceConstant.LC_DEFAULT));
      });

  test(
      'detectLocale should return the Locale based on the detected language code',
          () async {
        // Arrange
        final languageCode = 'en';
        when(settingRepository.loadString('languageCode'))
            .thenAnswer((_) => Future.value(languageCode));
        // Act
        final result = await sut.detectLocale();
        // Assert
        expect(result, equals(Locale(languageCode)));
      });

  test('saveLanguageCode should save the given language code', () async {
    // Arrange
    final languageCode = 'en';
    // Act
    await sut.saveLanguageCode(languageCode);
    // Assert
    verify(settingRepository.saveString('languageCode', languageCode))
        .called(1);
  });

  test('detectFontFamily should return the saved font family if available',
          () async {
        // Arrange
        final savedFontFamily = 'Roboto';
        when(settingRepository.loadString('fontFamily'))
            .thenAnswer((_) => Future.value(savedFontFamily));
        // Act
        final result = await sut.detectFontFamily();
        // Assert
        expect(result, equals(savedFontFamily));
      });

  test('detectFontFamily should return the default font family if not saved',
          () async {
        // Arrange
        when(settingRepository.loadString('fontFamily'))
            .thenAnswer((_) => Future.value(null));
        // Act
        final result = await sut.detectFontFamily();
        // Assert
        expect(result, equals(AppearanceConstant.FF_DEFAULT));
      });

  test('saveFontFamily should save the given font family', () async {
    // Arrange
    final fontFamily = 'Roboto';
    // Act
    await sut.saveFontFamily(fontFamily);
    // Assert
    verify(settingRepository.saveString('fontFamily', fontFamily)).called(1);
  });

  test('detectThemeType should return the saved theme type if available',
          () async {
        // Arrange
        final savedThemeType = 'dark';
        when(settingRepository.loadString('themeType'))
            .thenAnswer((_) => Future.value(savedThemeType));
        // Act
        final result = await sut.detectThemeType();
        // Assert
        expect(result, equals(savedThemeType));
      });

  test('detectThemeType should return the default theme type if not saved',
          () async {
        // Arrange
        when(settingRepository.loadString('themeType'))
            .thenAnswer((_) => Future.value(null));
        // Act
        final result = await sut.detectThemeType();
        // Assert
        expect(result, equals(AppearanceConstant.THEME_DEFAULT));
      });

  test('saveThemeType should save the given theme type', () async {
    // Arrange
    final themeType = 'dark';
    // Act
    await sut.saveThemeType(themeType);
    // Assert
    verify(settingRepository.saveString('themeType', themeType)).called(1);
  });

  test(
      'detectSelectedSourceCurrencyCode should return the saved selected source currency code if available',
          () async {
        // Arrange
        when(settingRepository.loadString('selectedSourceCurrencyCode'))
            .thenAnswer((_) => Future.value('USD'));
        when(currencyFeatureFacade.loadVisibleSourceCurrencyCodes())
            .thenAnswer((_) => Future.value(['USD', 'EUR']));
        // Act
        final result = await sut.detectSelectedSourceCurrencyCode();
        // Assert
        expect(result, equals('USD'));
      });

  test(
      'detectSelectedSourceCurrencyCode should return the first visible source currency code,' +
          ' if selected source currency code is not available in repository',
          () async {
        // Arrange
        when(settingRepository.loadString('selectedSourceCurrencyCode'))
            .thenAnswer((_) => Future.value('RUB'));
        when(currencyFeatureFacade.loadVisibleSourceCurrencyCodes())
            .thenAnswer((_) => Future.value(['USD', 'EUR']));
        // Act
        final result = await sut.detectSelectedSourceCurrencyCode();
        // Assert
        expect(result, equals('USD'));
      });

  test(
      'saveDefaultSourceCurrencyCode should save the given default source currency code',
          () async {
        // Arrange
        final currencyCode = 'USD';
        // Act
        await sut.saveDefaultSourceCurrencyCode(currencyCode);
        // Assert
        verify(settingRepository.saveString(
            'selectedSourceCurrencyCode', currencyCode))
            .called(1);
      });

  test(
      'detectSelectedTargetCurrencyCode should return the first visible target currency code,'
          + ' if selected target currency code is not available in repository',
          () async {
        // Arrange
        when(settingRepository.loadString('selectedTargetCurrencyCode'))
            .thenAnswer((_) => Future.value('RUB'));
        when(currencyFeatureFacade.loadVisibleTargetCurrencyCodes())
            .thenAnswer((_) => Future.value(['EUR', 'GBP']));
        // Act
        final result = await sut.detectSelectedTargetCurrencyCode('USD');
        // Assert
        expect(result, equals('EUR'));
      });

  test(
      'detectSelectedTargetCurrencyCode should return the first visible target currency code,'
          +
          ' if selected target currency code is the same as source currency code',
          () async {
        // Arrange
        when(settingRepository.loadString('selectedTargetCurrencyCode'))
            .thenAnswer((_) => Future.value('USD'));
        when(currencyFeatureFacade.loadVisibleTargetCurrencyCodes())
            .thenAnswer((_) => Future.value(['EUR', 'GBP']));
        // Act
        final result = await sut.detectSelectedTargetCurrencyCode('USD');
        // Assert
        expect(result, equals('EUR'));
      });

  test(
      'detectSelectedTargetCurrencyCode should return the second visible target currency code,'
          +
          ' if selected target currency code is not among available target currency codes'
          +
          ' and the first visible target currency code is the same as source currency code',
    () async {
      // Arrange
      when(settingRepository.loadString('selectedTargetCurrencyCode'))
          .thenAnswer((_) => Future.value('USD'));
      when(currencyFeatureFacade.loadVisibleTargetCurrencyCodes())
          .thenAnswer((_) => Future.value(['EUR', 'GBP']));
      // Act
      final result = await sut.detectSelectedTargetCurrencyCode('EUR');
      // Assert
      expect(result, equals('GBP'));
    });

  test(
      'saveDefaultTargetCurrencyCode should save the given default target currency code',
      () async {
    // Arrange
    final currencyCode = 'EUR';
    // Act
    await sut.saveDefaultTargetCurrencyCode(currencyCode);
    // Assert
    verify(settingRepository.saveString(
            'selectedTargetCurrencyCode', currencyCode))
        .called(1);
  });

  test(
      'detectVisibleSourceCurrencyCodes should return the saved in setting'
          + ' repository visible source currency codes if available',
      () async {
    // Arrange
    final savedCurrencyCodes = ['USD', 'EUR'];
    when(settingRepository.loadVisibleSourceCurrencyCodes())
        .thenAnswer((_) => Future.value(savedCurrencyCodes));
    // Act
    final result = await sut.detectVisibleSourceCurrencyCodes();
    // Assert
    expect(result, equals(savedCurrencyCodes));
  });

  test(
      'detectVisibleSourceCurrencyCodes should load visible source currency codes'
          + ' from currency feature facade (currency repository) if not saved',
      () async {
    // Arrange
    final visibleCurrencyCodes = ['USD', 'EUR'];
    when(settingRepository.loadVisibleSourceCurrencyCodes())
        .thenAnswer((_) => Future.value(null));
    when(currencyFeatureFacade.loadVisibleSourceCurrencyCodes())
        .thenAnswer((_) => Future.value(visibleCurrencyCodes));
    // Act
    final result = await sut.detectVisibleSourceCurrencyCodes();
    // Assert
    expect(result, equals(visibleCurrencyCodes));
  });

  test(
      'saveVisibleSourceCurrencyCodes should save the given visible source currency codes',
      () async {
    // Arrange
    final currencyCodes = ['USD', 'EUR'];
    // Act
    await sut.saveVisibleSourceCurrencyCodes(currencyCodes);
    // Assert
    verify(settingRepository.saveVisibleSourceCurrencyCodes(currencyCodes))
        .called(1);
  });

  test(
      'detectVisibleTargetCurrencyCodes should return the saved visible target currency codes if available',
      () async {
    // Arrange
    final savedCurrencyCodes = ['EUR', 'GBP'];
    when(settingRepository.loadVisibleTargetCurrencyCodes())
        .thenAnswer((_) => Future.value(savedCurrencyCodes));
    // Act
    final result = await sut.detectVisibleTargetCurrencyCodes();
    // Assert
    expect(result, equals(savedCurrencyCodes));
  });

  test(
      'detectVisibleTargetCurrencyCodes should load visible target currency codes from currency feature facade if not saved',
      () async {
    // Arrange
    final visibleCurrencyCodes = ['EUR', 'GBP'];
    when(settingRepository.loadVisibleTargetCurrencyCodes())
        .thenAnswer((_) => Future.value(null));
    when(currencyFeatureFacade.loadVisibleTargetCurrencyCodes())
        .thenAnswer((_) => Future.value(visibleCurrencyCodes));
    // Act
    final result = await sut.detectVisibleTargetCurrencyCodes();
    // Assert
    expect(result, equals(visibleCurrencyCodes));
  });

  test(
      'saveVisibleTargetCurrencyCodes should save the given visible target currency codes',
      () async {
    // Arrange
    final currencyCodes = ['EUR', 'GBP'];
    // Act
    await sut.saveVisibleTargetCurrencyCodes(currencyCodes);
    // Assert
    verify(settingRepository.saveVisibleTargetCurrencyCodes(currencyCodes))
        .called(1);
  });
}
