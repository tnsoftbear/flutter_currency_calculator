import 'package:hive/hive.dart';

part 'exchange_rate_record.g.dart';

@HiveType(typeId: 1)
class ExchangeRateRecord {
  @HiveField(0)
  String sourceCurrencyCode = '';

  @HiveField(1)
  String targetCurrencyCode = '';

  @HiveField(2)
  double exchangeRate = 0.0;

  @HiveField(3)
  DateTime createdAt = DateTime.now().toUtc();

  ExchangeRateRecord({
    required this.sourceCurrencyCode,
    required this.targetCurrencyCode,
    required this.exchangeRate,
    required this.createdAt,
  });
}
