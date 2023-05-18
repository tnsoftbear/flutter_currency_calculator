import 'package:clock/clock.dart';
import 'package:currency_calc/feature/currency/internal/domain/repository/update_time_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class UpdateTimeSharedPrefsDataSource implements UpdateTimeDataSource {
  UpdateTimeSharedPrefsDataSource(this._clock);

  static const lastUpdateTimestampKey = 'lastUpdateTimestamp';

  final Clock _clock;

  @override
  Future<DateTime?> loadLastUpdateDate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(lastUpdateTimestampKey)) {
      return null;
    }

    final int lastUpdateTimestamp = prefs.getInt(lastUpdateTimestampKey) ?? 0;
    return DateTime.fromMillisecondsSinceEpoch(lastUpdateTimestamp);
  }

  @override
  Future<void> saveLastUpdateDateToNow() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final currentDateUtcTs = _clock.now().toUtc().millisecondsSinceEpoch;
    await prefs.setInt(lastUpdateTimestampKey, currentDateUtcTs);
  }
}
