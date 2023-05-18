import 'package:clock/clock.dart';
import 'package:currency_calc/core/network/http/dio_http_client.dart';
import 'package:currency_calc/feature/conversion/internal/app/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/internal/app/fetch/rate_fetcher_factory.dart';
import 'package:currency_calc/feature/conversion/internal/app/translate/conversion_validation_translator.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/domain/repository/exchange_rate_record_repository_impl.dart';
import 'package:currency_calc/feature/conversion/internal/infra/data_source/exchange_rate_record_hive_data_source.dart';

final class ConversionFeatureDic {
  ConversionFeatureDic() {
    _conversionValidationTranslator = ConversionValidationTranslator();
    final exchangeRateRecordRepository =
        ExchangeRateRecordRepositoryImpl(ExchangeRateRecordHiveDataSource());
    _rateFetcher = RateFetcherFactory(ConversionConfig(), clock,
            exchangeRateRecordRepository, DioHttpClient())
        .create();
  }

  late final ConversionValidationTranslator _conversionValidationTranslator;
  late final RateFetcher _rateFetcher;

  ConversionValidationTranslator get conversionValidationTranslator =>
      _conversionValidationTranslator;

  RateFetcher get rateFetcher => _rateFetcher;
}
