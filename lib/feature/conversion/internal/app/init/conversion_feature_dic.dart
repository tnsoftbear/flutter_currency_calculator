import 'package:clock/clock.dart';
import 'package:currency_calc/feature/conversion/internal/app/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/internal/app/fetch/rate_fetcher_factory.dart';
import 'package:currency_calc/feature/conversion/internal/app/translate/conversion_validation_translator.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/repository/exchange_rate_record_repository.dart';

final class ConversionFeatureDic {
  ConversionFeatureDic() {
    _conversionValidationTranslator = ConversionValidationTranslator();
    _rateFetcher = RateFetcherFactory(
            ConversionConfig(), clock, ExchangeRateRecordRepository())
        .create();
  }

  late final ConversionValidationTranslator _conversionValidationTranslator;
  late final RateFetcher _rateFetcher;

  ConversionValidationTranslator get conversionValidationTranslator =>
      _conversionValidationTranslator;

  RateFetcher get rateFetcher => _rateFetcher;
}
