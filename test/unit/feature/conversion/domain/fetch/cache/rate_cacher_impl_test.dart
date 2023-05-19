import 'package:clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/rate_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/impl/rate_repository_cacher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/model/exchange_rate_record.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockExchangeRateRecordRepository extends Mock
    implements ExchangeRateRecordRepository {}

void main() {
  group('RateCacherImpl', () {
    final MockExchangeRateRecordRepository mockRepository =
        MockExchangeRateRecordRepository();
    final Clock clock = Clock.fixed(DateTime(2022, 1, 1));

    final RateCacher rateCacher = RateRepositoryCacher(60, clock, mockRepository);

    // test('get - returns null when record is null', () async {
    //   await rateCacher.get('USD', 'EUR').then((rate) => expect(rate, null)); // USD_EUR record does not exist
    // });

    // test('get - returns null when record is expired', () async {
    //   final expiredRecord = ExchangeRateRecord(
    //       sourceCurrencyCode: 'USD',
    //       targetCurrencyCode: 'JPY',
    //       exchangeRate: 111,
    //       createdAt: clock.now().subtract(Duration(seconds: 61)).toUtc());
    //   when(mockRepository.loadByKey('USD_JPY')).thenAnswer((_) async {
    //     return expiredRecord;
    //   });
    //
    //   final double? rate =
    //       await rateCacher.get('USD', 'JPY'); // USD_JPY record is expired
    //
    //   expect(rate, null);
    //   verify(mockRepository.deleteByKey('USD_JPY')).called(1);
    // });

    test('get - returns exchange rate when record exists and is valid',
        () async {
      when(mockRepository.loadByKey('EUR_GBP')).thenAnswer((_) async {
        final record = ExchangeRateRecord(
            sourceCurrencyCode: 'EUR',
            targetCurrencyCode: 'GBP',
            exchangeRate: 0.87,
            createdAt: clock.now().subtract(Duration(seconds: 59)).toUtc());
        return record;
      });

      final double? rate = await rateCacher.get('EUR', 'GBP');

      expect(rate, 0.87);
      verifyNever(mockRepository.deleteByKey('EUR_GBP'));
    });

    // test('set - saves exchange rate record in repository', () async {
    //   await rateCacher.set('EUR', 'JPY', 132);
    //
    //   final recordCaptor = verify(mockRepository.saveByKey(
    //       captureAny, captureAny))
    //       .captured
    //       .last as ExchangeRateRecord;
    //   expect(recordCaptor.sourceCurrencyCode, 'EUR');
    //   expect(recordCaptor.targetCurrencyCode, 'JPY');
    //   expect(recordCaptor.exchangeRate, 132);
    //   expect(recordCaptor.createdAt.isUtc, true);
    // });
  });
}
