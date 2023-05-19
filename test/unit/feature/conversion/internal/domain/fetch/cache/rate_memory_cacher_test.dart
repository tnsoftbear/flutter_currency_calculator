import 'package:clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/cache/impl/rate_memory_cacher.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RateMemoryCacher', () {
    late RateMemoryCacher rateMemoryCacher;
    late Clock clock;

    setUp(() {
      clock = Clock.fixed(DateTime(2023, 1, 1));
      rateMemoryCacher = RateMemoryCacher(60, clock);
    });

    test('get returns null when cache is empty', () async {
      final result = await rateMemoryCacher.get('USD', 'EUR');
      expect(result, isNull);
    });

    test('get returns null when record is expired', () async {
      await rateMemoryCacher.set('USD', 'EUR', 1.0);

      // Advance the clock by 61 seconds to expire the record
      clock = Clock.fixed(DateTime(2023, 1, 1).add(Duration(seconds: 61)));
      rateMemoryCacher = RateMemoryCacher(60, clock);

      final result = await rateMemoryCacher.get('USD', 'EUR');
      expect(result, isNull);
    });

    test('get returns the exchange rate when record is valid', () async {
      await rateMemoryCacher.set('USD', 'EUR', 1.0);

      final result = await rateMemoryCacher.get('USD', 'EUR');
      expect(result, equals(1.0));
    });

    test('set adds the exchange rate to the cache', () async {
      await rateMemoryCacher.set('USD', 'EUR', 1.0);

      final result = await rateMemoryCacher.get('USD', 'EUR');
      expect(result, equals(1.0));
    });
  });
}
