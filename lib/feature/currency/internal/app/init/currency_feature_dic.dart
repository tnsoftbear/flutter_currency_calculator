import 'package:currency_calc/core/clock/clock.dart';
import 'package:currency_calc/core/clock/date_time_clock.dart';
import 'package:currency_calc/feature/currency/internal/app/load/currency_loader.dart';
import 'package:currency_calc/feature/currency/internal/app/populate/currency_populator.dart';
import 'package:currency_calc/feature/currency/internal/app/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/currency/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_available_currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

class CurrencyFeatureDic {
  CurrencyFeatureDic() {
    _clock = DateTimeClock();
    final currencyRepository = CurrencyRepository(_clock);
    final currencyFetcher = FawazAhmedAvailableCurrencyFetcher();
    _currencyPopulator =
        CurrencyPopulator(_clock, currencyFetcher, currencyRepository);
    _currencyLoader = CurrencyLoader(currencyRepository, _currencyPopulator);
    _currencyVisibilityUpdater = CurrencyVisibilityUpdater(currencyRepository);
  }

  late final Clock _clock;
  late final CurrencyLoader _currencyLoader;
  late final CurrencyPopulator _currencyPopulator;
  late final CurrencyVisibilityUpdater _currencyVisibilityUpdater;

  Clock get clock => _clock;

  CurrencyLoader get currencyLoader => _currencyLoader;

  CurrencyPopulator get currencyPopulator => _currencyPopulator;

  CurrencyVisibilityUpdater get currencyVisibilityUpdater =>
      _currencyVisibilityUpdater;
}
