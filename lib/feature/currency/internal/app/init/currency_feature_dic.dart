import 'package:clock/clock.dart';
import 'package:currency_calc/core/network/http/impl/http_http_client.dart';
import 'package:currency_calc/feature/currency/internal/domain/fetch/load/fawaz_ahmed/fawaz_ahmed_available_currency_fetcher.dart';
import 'package:currency_calc/feature/currency/internal/domain/populate/currency_populator.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/currency_repository_impl.dart';
import 'package:currency_calc/feature/currency/internal/domain/update/currency_visibility_updater.dart';
import 'package:currency_calc/feature/currency/internal/infra/data_source/currency_hive_data_source.dart';
import 'package:currency_calc/feature/currency/internal/infra/data_source/update_time_shared_prefs_data_source.dart';

final class CurrencyFeatureDic {
  CurrencyFeatureDic() {
    _currencyRepository = CurrencyRepositoryImpl(
      CurrencyHiveDataSource(),
      UpdateTimeSharedPrefsDataSource(clock),
    );
    final currencyFetcher = FawazAhmedAvailableCurrencyFetcher(
        url:
            "https://cdn.jsdelivr.net/gh/fawazahmed0/currency-api@1/latest/currencies.json",
        httpClient: HttpHttpClient() // Used instead of DioHttpClient() for fun
        );
    _currencyPopulator =
        CurrencyPopulator(clock, currencyFetcher, currencyRepository);
    _currencyVisibilityUpdater = CurrencyVisibilityUpdater(currencyRepository);
  }

  late final CurrencyRepository _currencyRepository;
  late final CurrencyPopulator _currencyPopulator;
  late final CurrencyVisibilityUpdater _currencyVisibilityUpdater;

  Clock get clock => Clock();

  CurrencyRepository get currencyRepository => _currencyRepository;

  CurrencyPopulator get currencyPopulator => _currencyPopulator;

  CurrencyVisibilityUpdater get currencyVisibilityUpdater =>
      _currencyVisibilityUpdater;
}
