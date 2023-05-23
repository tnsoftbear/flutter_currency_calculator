import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'exchange_rate_record.g.dart';

@HiveType(typeId: 1)
final class ExchangeRateRecord extends Equatable {
  ExchangeRateRecord({
    required this.sourceCurrencyCode,
    required this.targetCurrencyCode,
    required this.exchangeRate,
    required this.createdAt,
  });

  @HiveField(0)
  final String sourceCurrencyCode;

  @HiveField(1)
  final String targetCurrencyCode;

  @HiveField(2)
  final double exchangeRate;

  @HiveField(3)
  final DateTime createdAt;

  ExchangeRateRecord copyWith({
    String? sourceCurrencyCode,
    String? targetCurrencyCode,
    double? exchangeRate,
    DateTime? createdAt,
  }) {
    return ExchangeRateRecord(
      sourceCurrencyCode: sourceCurrencyCode ?? this.sourceCurrencyCode,
      targetCurrencyCode: targetCurrencyCode ?? this.targetCurrencyCode,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object> get props => [
        sourceCurrencyCode,
        targetCurrencyCode,
        exchangeRate,
        createdAt,
      ];
}
