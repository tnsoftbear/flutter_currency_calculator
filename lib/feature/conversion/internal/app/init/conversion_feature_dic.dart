import 'package:currency_calc/common/clock/clock.dart';
import 'package:currency_calc/common/clock/date_time_clock.dart';
import 'package:currency_calc/feature/conversion/internal/app/config/conversion_config.dart';
import 'package:currency_calc/feature/conversion/internal/app/fetch/rate_fetcher_factory.dart';
import 'package:currency_calc/feature/conversion/internal/app/translate/conversion_validation_translator.dart';
import 'package:currency_calc/feature/conversion/internal/domain/fetch/load/rate_fetcher.dart';
import 'package:currency_calc/feature/conversion/internal/infra/repository/exchange_rate_record_repository.dart';

class ConversionFeatureDic {
  ConversionFeatureDic() {
    _clock = DateTimeClock();
    _conversionValidationTranslator = ConversionValidationTranslator();

    final exchangeRateRecordRepository = ExchangeRateRecordRepository();
    final conversionConfig = ConversionConfig();
    _rateFetcher = RateFetcherFactory(
            conversionConfig, _clock, exchangeRateRecordRepository)
        .create();
  }

  late final Clock _clock;
  late final ConversionValidationTranslator _conversionValidationTranslator;
  late final RateFetcher _rateFetcher;

  Clock get clock => _clock;

  ConversionValidationTranslator get conversionValidationTranslator =>
      _conversionValidationTranslator;

  RateFetcher get rateFetcher => _rateFetcher;
}
