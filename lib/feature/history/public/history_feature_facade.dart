import 'package:currency_calc/feature/history/internal/app/init/history_feature_initializer.dart';
import 'package:currency_calc/feature/history/internal/app/model/last_history_model.dart';
import 'package:currency_calc/feature/history/internal/infra/repository/conversion_history_record_repository.dart';
import 'package:currency_calc/feature/history/internal/ui/screen/all_history_screen.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/last_history/last_history_widget.dart';

class HistoryFeatureFacade {
  late final _conversionHistoryRecordRepository;

  HistoryFeatureFacade() {
    HistoryFeatureInitializer();
    _conversionHistoryRecordRepository = ConversionHistoryRecordRepository();
  }

  LastHistoryModel createLastHistoryModel() {
    return LastHistoryModel(_conversionHistoryRecordRepository);
  }

  // void addConversionHistoryRecord(
  //     String sourceCurrencyCode,
  //     String targetCurrencyCode,
  //     double sourceAmount,
  //     double targetAmount,
  //     double rate) {
  //   LastHistoryModel(_conversionHistoryRecordRepository).add(
  //       sourceCurrencyCode,
  //       targetCurrencyCode,
  //       sourceAmount,
  //       targetAmount,
  //       rate);
  // }

  // --- Widgets ---

  LastHistoryWidget createLastHistoryWidget() {
    return const LastHistoryWidget();
  }

  AllHistoryScreen createAllHistoryScreen() {
    return const AllHistoryScreen();
  }
}
