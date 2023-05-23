import 'package:clock/clock.dart';
import 'package:currency_calc/feature/history/internal/domain/last_history/model/last_history_model.dart';
import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart';
import 'package:currency_calc/feature/history/internal/domain/repository/conversion_history_record_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'last_history_model_test.mocks.dart';

class MockClock extends Mock implements Clock {}

@GenerateNiceMocks([MockSpec<ConversionHistoryRecordRepository>()])
void main() {
  late LastHistoryModel sut;
  late Clock clock;
  late MockConversionHistoryRecordRepository conversionHistoryRecordRepository;

  setUp(() {
    clock = Clock.fixed(DateTime(2023, 1, 1));
    conversionHistoryRecordRepository = MockConversionHistoryRecordRepository();
    sut = LastHistoryModel(
      clock,
      conversionHistoryRecordRepository,
      lastHistoryRecordCount: 5,
    );
  });

  test('load should load the last N history records from the repository',
      () async {
    // Arrange
    final totalCount = 12;
    final records = List.generate(
      totalCount,
      (index) => ConversionHistoryRecord(
        sourceCurrencyCode: 'USD',
        targetCurrencyCode: 'EUR',
        sourceAmount: 100.0 + index,
        targetAmount: 85.0 + index,
        rate: 0.85,
        date: clock.now().toUtc(),
      ),
    );
    when(conversionHistoryRecordRepository.countAll())
        .thenAnswer((_) => Future.value(totalCount));
    when(conversionHistoryRecordRepository.loadAll())
        .thenAnswer((_) => Future.value(records));

    // Act
    final actual = await sut.load();

    // Assert
    final expected = records.reversed.take(5).toList();
    expect(actual, equals(expected));
    expect(sut.records, equals(expected));
  });

  test('add should save a new history record to the repository', () async {
    // Arrange
    final sourceCurrencyCode = 'USD';
    final sourceAmount = 100.0;
    final targetCurrencyCode = 'EUR';
    final targetAmount = 85.0;
    final rate = 0.85;

    // Act
    await sut.add(
      sourceCurrencyCode,
      sourceAmount,
      targetCurrencyCode,
      targetAmount,
      rate,
    );

    // Assert
    final expected = ConversionHistoryRecord(
      sourceCurrencyCode: sourceCurrencyCode,
      targetCurrencyCode: targetCurrencyCode,
      sourceAmount: sourceAmount,
      targetAmount: targetAmount,
      rate: rate,
      date: clock.now().toUtc(),
    );
    verify(conversionHistoryRecordRepository.save(expected)).called(1);
    expect(sut.records, isEmpty);
  });

  test(
      'deleteRecordByTableIndex should delete the record from the repository by the table index',
      () async {
    // Arrange
    final totalCount = 10;
    final tableIndex = 3;
    final actualIndex = 6;
    when(conversionHistoryRecordRepository.countAll())
        .thenAnswer((_) => Future.value(totalCount));

    // Act
    await sut.deleteRecordByTableIndex(tableIndex);

    // Assert
    verify(conversionHistoryRecordRepository.deleteByIndex(actualIndex))
        .called(1);
    expect(sut.records, isEmpty);
  });
}
