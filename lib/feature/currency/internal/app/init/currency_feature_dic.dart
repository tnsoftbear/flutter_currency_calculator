import 'package:currency_calc/feature/currency/internal/app/load/currency_loader.dart';
import 'package:currency_calc/feature/currency/internal/app/populate/currency_populator.dart';
import 'package:currency_calc/feature/currency/internal/app/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/currency/internal/infra/fetch/load/fawaz_ahmed/fawaz_ahmed_available_currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/infra/repository/currency_repository.dart';

class CurrencyFeatureDic {
  CurrencyFeatureDic() {
    _currencyRepository = CurrencyRepository();
    final currencyFetcher = FawazAhmedAvailableCurrencyFetcher();
    _currencyPopulator =
        CurrencyPopulator(_currencyRepository, currencyFetcher);
    _currencyLoader = CurrencyLoader(_currencyRepository, _currencyPopulator);
    _currencyVisibilityUpdater = CurrencyVisibilityUpdater(_currencyRepository);
  }

  late CurrencyLoader _currencyLoader;
  late CurrencyPopulator _currencyPopulator;
  late CurrencyRepository _currencyRepository;
  late CurrencyVisibilityUpdater _currencyVisibilityUpdater;

  CurrencyPopulator get currencyPopulator => _currencyPopulator;

  CurrencyLoader get currencyLoader => _currencyLoader;

  CurrencyRepository get currencyRepository => _currencyRepository;

  CurrencyVisibilityUpdater get currencyVisibilityUpdater =>
      _currencyVisibilityUpdater;
}
