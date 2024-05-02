// Mocks generated by Mockito 5.4.4 from annotations
// in talacare/test/data/repositories/game_history_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:talacare/data/datasources/game_history_remote_datasource.dart'
    as _i2;
import 'package:talacare/data/models/game_history_model.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [GameHistoryRemoteDatasource].
///
/// See the documentation for Mockito's code generation for more information.
class MockGameHistoryRemoteDatasource extends _i1.Mock
    implements _i2.GameHistoryRemoteDatasource {
  @override
  _i3.Future<void> createGameHistory(_i4.GameHistoryModel? gameHistoryModel) =>
      (super.noSuchMethod(
        Invocation.method(
          #createGameHistory,
          [gameHistoryModel],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<_i4.GameHistoryModel?> getHighestScoreHistory(String? gameType) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHighestScoreHistory,
          [gameType],
        ),
        returnValue: _i3.Future<_i4.GameHistoryModel?>.value(),
        returnValueForMissingStub: _i3.Future<_i4.GameHistoryModel?>.value(),
      ) as _i3.Future<_i4.GameHistoryModel?>);
}
