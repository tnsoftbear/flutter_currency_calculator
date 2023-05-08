import 'package:hive/hive.dart';

part 'currency.g.dart';

typedef CurrencyMap = Map<String, Currency>;

@HiveType(typeId: 2)
class Currency {
  @HiveField(0)
  final String code;
  @HiveField(1)
  final String name;
  @HiveField(2)
  bool isVisibleForSource;
  @HiveField(3)
  bool isVisibleForTarget;

  Currency(this.code, this.name,
      [this.isVisibleForSource = false, this.isVisibleForTarget = false]);
}