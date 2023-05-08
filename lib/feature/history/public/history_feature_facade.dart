import 'package:currency_calc/feature/history/internal/app/init/history_feature_initializer.dart';
import 'package:currency_calc/feature/history/internal/ui/widget/last_history/last_history_widget.dart';

class HistoryFeatureFacade {
  HistoryFeatureFacade() {
    HistoryFeatureInitializer();
  }

  LastHistoryWidget createLastHistoryWidget() {
    return const LastHistoryWidget();
  }
}