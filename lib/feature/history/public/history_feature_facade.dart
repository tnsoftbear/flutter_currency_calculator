import 'package:currency_calc/feature/history/internal/app/init/history_feature_dic.dart';
import 'package:currency_calc/feature/history/internal/app/init/history_feature_initializer.dart';
import 'package:currency_calc/feature/history/internal/app/model/last_history_model.dart';
import 'package:currency_calc/feature/history/internal/ui/screen/all_history_screen.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/last_history/last_history_widget.dart';

final class HistoryFeatureFacade {
  HistoryFeatureFacade() {
    HistoryFeatureInitializer();
    this._dic = HistoryFeatureDic();
  }

  late final HistoryFeatureDic _dic;

  LastHistoryModel createLastHistoryModel() {
    return LastHistoryModel(_dic.clock, _dic.conversionHistoryRecordRepository);
  }

  // --- Widgets ---

  LastHistoryWidget createLastHistoryWidget() {
    return const LastHistoryWidget();
  }

  AllHistoryScreen createAllHistoryScreen() {
    return AllHistoryScreen(_dic.conversionHistoryRecordRepository);
  }
}
