import 'package:currency_calc/common/clock/clock.dart';

class DateTimeClock implements Clock {
  @override
  DateTime getCurrentDateSys() => DateTime.now();

  @override
  DateTime getCurrentDateUtc() => DateTime.now().toUtc();
}
