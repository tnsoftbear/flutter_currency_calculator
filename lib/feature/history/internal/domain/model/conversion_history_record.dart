import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'conversion_history_record.g.dart';

@HiveType(typeId: 0)
final class ConversionHistoryRecord extends Equatable {
  const ConversionHistoryRecord(
      {required this.sourceCurrencyCode,
      required this.sourceAmount,
      required this.targetCurrencyCode,
      required this.targetAmount,
      required this.rate,
      required this.date});

  @HiveField(0)
  final String sourceCurrencyCode;

  @HiveField(1)
  final double sourceAmount;

  @HiveField(2)
  final String targetCurrencyCode;

  @HiveField(3)
  final double targetAmount;

  @HiveField(4)
  final double rate;

  @HiveField(5)
  final DateTime date;

  ConversionHistoryRecord copyWith({
    String? sourceCurrencyCode,
    double? sourceAmount,
    String? targetCurrencyCode,
    double? targetAmount,
    double? rate,
    DateTime? date,
  }) {
    return ConversionHistoryRecord(
      sourceCurrencyCode: sourceCurrencyCode ?? this.sourceCurrencyCode,
      sourceAmount: sourceAmount ?? this.sourceAmount,
      targetCurrencyCode: targetCurrencyCode ?? this.targetCurrencyCode,
      targetAmount: targetAmount ?? this.targetAmount,
      rate: rate ?? this.rate,
      date: date ?? this.date,
    );
  }

  @override
  List<Object> get props => [
    sourceCurrencyCode,
    sourceAmount,
    targetCurrencyCode,
    targetAmount,
    rate,
    date
  ];
}
