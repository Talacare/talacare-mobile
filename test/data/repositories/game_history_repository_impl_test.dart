import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/game_history_remote_datasource.dart';
import 'package:talacare/data/models/game_history_model.dart';
import 'package:talacare/data/repositories/game_history_repository_impl.dart';
import 'game_history_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GameHistoryRemoteDatasource>(
      onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  late GameHistoryRepositoryImpl repository;
  late MockGameHistoryRemoteDatasource mockRemoteDatasource;

  final gameHistoryModel = GameHistoryModel(
    gameType: 'PUZZLE',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    score: 75,
  );

  final expectedHighestScoreGameHistoryModel = GameHistoryModel(
    gameType: 'PUZZLE',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    score: 100,
  );

  final gameType = 'PUZZLE';

  setUp(() {
    mockRemoteDatasource = MockGameHistoryRemoteDatasource();
    repository = GameHistoryRepositoryImpl(mockRemoteDatasource);
  });

  test('should call create game history of game history remote datasource',
      () async {
    when(mockRemoteDatasource.createGameHistory(gameHistoryModel))
        .thenAnswer(((_) async => Future.value()));

    await repository.createGameHistory(gameHistoryModel);

    verify(mockRemoteDatasource.createGameHistory(gameHistoryModel)).called(1);
  });

  test(
      'should call get highest score history of game history remote datasource and return appropriate data',
      () async {
    when(mockRemoteDatasource.getHighestScoreHistory(gameType))
        .thenAnswer(((_) async => expectedHighestScoreGameHistoryModel));

    final highestScoreGameHistoryModel =
        await repository.getHighestScoreHistory(gameType);

    expect(highestScoreGameHistoryModel,
        equals(expectedHighestScoreGameHistoryModel));

    verify(mockRemoteDatasource.getHighestScoreHistory(gameType)).called(1);
  });
}
