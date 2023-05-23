import 'package:hive/hive.dart';

part 'currency.g.dart';

typedef CurrencyMap = Map<String, Currency>;

@HiveType(typeId: 2)
final class Currency {
  Currency(this.code, this.name,
      [this.isVisibleForSource = false, this.isVisibleForTarget = false]) {
    code = code.toUpperCase();
  }

  @HiveField(0)
  String code;
  @HiveField(1)
  String name;
  @HiveField(2)
  bool isVisibleForSource;
  @HiveField(3)
  bool isVisibleForTarget;

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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency &&
        other.code == code &&
        other.name == name &&
        other.isVisibleForSource == isVisibleForSource &&
        other.isVisibleForTarget == isVisibleForTarget;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        isVisibleForSource.hashCode ^
        isVisibleForTarget.hashCode;
  }
}
