// Mocks generated by Mockito 5.4.0 from annotations
// in currency_calc/test/unit/feature/history/internal/domain/last_history/model/last_history_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:currency_calc/feature/history/internal/domain/model/conversion_history_record.dart'
    as _i4;
import 'package:currency_calc/feature/history/internal/domain/repository/conversion_history_record_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ConversionHistoryRecordRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockConversionHistoryRecordRepository extends _i1.Mock
    implements _i2.ConversionHistoryRecordRepository {
  @override
  _i3.Future<int> countAll() => (super.noSuchMethod(
        Invocation.method(
          #countAll,
          [],
        ),
        returnValue: _i3.Future<int>.value(0),
        returnValueForMissingStub: _i3.Future<int>.value(0),
      ) as _i3.Future<int>);
  @override
  _i3.Future<List<_i4.ConversionHistoryRecord>> loadAll() =>
      (super.noSuchMethod(
        Invocation.method(
          #loadAll,
          [],
        ),
        returnValue: _i3.Future<List<_i4.ConversionHistoryRecord>>.value(
            <_i4.ConversionHistoryRecord>[]),
        returnValueForMissingStub:
            _i3.Future<List<_i4.ConversionHistoryRecord>>.value(
                <_i4.ConversionHistoryRecord>[]),
      ) as _i3.Future<List<_i4.ConversionHistoryRecord>>);
  @override
  _i3.Future<void> save(_i4.ConversionHistoryRecord? record) =>
      (super.noSuchMethod(
        Invocation.method(
          #save,
          [record],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
  @override
  _i3.Future<void> deleteByIndex(int? index) => (super.noSuchMethod(
        Invocation.method(
          #deleteByIndex,
          [index],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
