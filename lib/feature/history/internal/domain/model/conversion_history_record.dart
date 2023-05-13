import 'package:hive/hive.dart';

part 'conversion_history_record.g.dart';

@HiveType(typeId: 0)
class ConversionHistoryRecord extends HiveObject {
  @HiveField(0)
  String sourceCurrencyCode = '';

  @HiveField(1)
  double sourceAmount = 0.0;

  @HiveField(2)
  String targetCurrencyCode = '';

  @HiveField(3)
  double targetAmount = 0.0;

  @HiveField(4)
  double rate = 0.0;

  @HiveField(5)
  DateTime date = DateTime.now().toUtc();

  toList() {
    return [
      sourceCurrencyCode,
      sourceAmount,
      targetCurrencyCode,
      targetAmount,
      rate,
      date
    ];
  }
}
