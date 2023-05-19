// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_rate_record.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExchangeRateRecordAdapter extends TypeAdapter<ExchangeRateRecord> {
  @override
  final int typeId = 1;

  @override
  ExchangeRateRecord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExchangeRateRecord(
      sourceCurrencyCode: fields[0] as String,
      targetCurrencyCode: fields[1] as String,
      exchangeRate: fields[2] as double,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExchangeRateRecord obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sourceCurrencyCode)
      ..writeByte(1)
      ..write(obj.targetCurrencyCode)
      ..writeByte(2)
      ..write(obj.exchangeRate)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeRateRecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
