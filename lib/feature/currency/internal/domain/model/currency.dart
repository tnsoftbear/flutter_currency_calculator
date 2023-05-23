import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'currency.g.dart';

typedef CurrencyMap = Map<String, Currency>;

@HiveType(typeId: 2)
final class Currency with EquatableMixin {
  Currency(this.code, this.name,
      [this.isVisibleForSource = false, this.isVisibleForTarget = false]) {
    code = code.toUpperCase();
  }

  @HiveField(0)
  String code;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final bool isVisibleForSource;
  @HiveField(3)
  final bool isVisibleForTarget;

  Currency copyWith({
    String? code,
    String? name,
    bool? isVisibleForSource,
    bool? isVisibleForTarget,
  }) {
    return Currency(
      code ?? this.code,
      name ?? this.name,
      isVisibleForSource ?? this.isVisibleForSource,
      isVisibleForTarget ?? this.isVisibleForTarget,
    );
  }

  get props => [code, name, isVisibleForSource, isVisibleForTarget];
}
