import 'package:hive/hive.dart';

part 'exchange_rate_record.g.dart';

@HiveType(typeId: 1)
class ExchangeRateRecord {
  @HiveField(0)
  String sourceCurrency = '';

  @HiveField(1)
  String targetCurrency = '';

  @HiveField(2)
  double exchangeRate = 0.0;

  @HiveField(3)
  DateTime createdAt = DateTime.now();

  ExchangeRateRecord({
    required this.sourceCurrency,
    required this.targetCurrency,
    required this.exchangeRate,
    required this.createdAt,
  });
}
