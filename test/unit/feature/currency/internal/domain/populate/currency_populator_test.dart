import 'package:clock/clock.dart';
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/domain/model/currency.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/populate/currency_populator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_populator_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CurrencyFetcher>()])
@GenerateNiceMocks([MockSpec<CurrencyRepository>()])
void main() {
  group('CurrencyPopulator', () {
    late Clock clock;
    late MockCurrencyFetcher fetcher;
    late MockCurrencyRepository repo;
    late CurrencyPopulator sut;

    setUp(() {
      clock = Clock.fixed(DateTime(2023, 1, 9));
      fetcher = MockCurrencyFetcher();
      repo = MockCurrencyRepository();
      sut = CurrencyPopulator(clock, fetcher, repo);
    });

    test('PopulateIfNeeded - Must populate', () async {
      when(repo.loadLastUpdateDate()).thenAnswer((_) => Future.value(null));
      when(repo.loadAllIndexedByCode()).thenAnswer((_) => Future.value({}));
      when(repo.saveLastUpdateDateToNow()).thenAnswer((_) => Future.value());
      when(repo.saveAll(any)).thenAnswer((_) => Future.value());

      when(fetcher.fetchAvailableCurrencies())
          .thenAnswer((_) => Future.value(_getFetchedCurrencies()));

      await sut.populateIfNeeded();

      CurrencyMap newCurrencies = verify(repo.saveAll(captureAny)).captured[0];
      expect(
          newCurrencies,
          equals({
            'EUR': Currency('EUR', 'Euro', true, true),
            'GBP': Currency('GBP', 'British Pound', true, true),
            'RUB': Currency('RUB', 'Russian Ruble', true, true),
          }));
    });

    test(
        'PopulateIfNeeded - No need to populate, because not expired from the last update time',
        () async {
      final lastUpdateDate = DateTime(2023, 1, 2);
      when(repo.loadLastUpdateDate())
          .thenAnswer((_) => Future.value(lastUpdateDate));

      await sut.populateIfNeeded();

      verifyNever(fetcher.fetchAvailableCurrencies());
      verifyNever(repo.saveLastUpdateDateToNow());
      verifyNever(repo.saveAll(any));
      verifyNever(repo.loadAllIndexedByCode());
      verify(repo.loadLastUpdateDate()).called(1);
    });

    test('PopulateIfNeeded - Need to populate', () async {
      final lastUpdateDate = DateTime(2023, 1, 1);
      when(repo.loadLastUpdateDate())
          .thenAnswer((_) => Future.value(lastUpdateDate));
      when(repo.saveLastUpdateDateToNow()).thenAnswer((_) => Future.value());
      when(repo.saveAll(any)).thenAnswer((_) => Future.value());

      when(repo.loadAllIndexedByCode())
          .thenAnswer((_) => Future.value(_getExistingCurrencies()));
      when(fetcher.fetchAvailableCurrencies())
          .thenAnswer((_) => Future.value(_getFetchedCurrencies()));

      await sut.populateIfNeeded();

      VerificationResult vr = verify(repo.saveAll(captureAny));
      vr.called(1);
      CurrencyMap newCurrencies = vr.captured[0];
      expect(
          newCurrencies,
          equals({
            'GBP': Currency('GBP', 'British Pound', true, true),
            'RUB': Currency('RUB', 'Russian Ruble', true, true),
          }));
    });

    test('PopulateIfNeeded - No new currencies', () async {
      final lastUpdateDate = DateTime(2023, 1, 1);
      when(repo.loadLastUpdateDate())
          .thenAnswer((_) => Future.value(lastUpdateDate));
      when(repo.saveLastUpdateDateToNow()).thenAnswer((_) => Future.value());
      when(repo.saveAll(any)).thenAnswer((_) => Future.value());

      when(repo.loadAllIndexedByCode())
          .thenAnswer((_) => Future.value(_getExistingCurrencies()));
      when(fetcher.fetchAvailableCurrencies())
          .thenAnswer((_) => Future.value(_getExistingCurrencies()));

      await sut.populateIfNeeded();

      verifyNever(repo.saveAll(any));
    });
  });
}

CurrencyMap _getExistingCurrencies() {
  return {
    'USD': Currency('USD', 'US Dollar'),
    'EUR': Currency('EUR', 'Euro'),
  };
}

CurrencyMap _getFetchedCurrencies() {
  return {
    'EUR': Currency('EUR', 'Euro'),
    'GBP': Currency('GBP', 'British Pound'),
    'RUB': Currency('RUB', 'Russian Ruble'),
  };
}
