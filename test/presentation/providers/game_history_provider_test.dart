import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/domain/usecases/game_history_usecase.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'game_history_provider_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<GameHistoryUseCase>(onMissingStub: OnMissingStub.returnDefault)])
void main() {
  late GameHistoryProvider gameHistoryProvider;
  late MockGameHistoryUseCase mockGameHistoryUseCase;

  final gameHistoryEntity = GameHistoryEntity(
    gameType: 'PUZZLE',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    score: 100,
  );

  setUp(() {
    mockGameHistoryUseCase = MockGameHistoryUseCase();
    gameHistoryProvider = GameHistoryProvider(useCase: mockGameHistoryUseCase);
  });

  test('should correctly handle a successful game history creation', () async {
    when(mockGameHistoryUseCase.createGameHistory(any))
        .thenAnswer(((_) async => Future.value()));

    await gameHistoryProvider.createGameHistory(gameHistoryEntity);

    expect(gameHistoryProvider.isLoading, false);
    expect(gameHistoryProvider.isError, false);
    expect(gameHistoryProvider.message, 'Successfully created game history');
    verify(mockGameHistoryUseCase.createGameHistory(gameHistoryEntity))
        .called(1);
  });

  test('should correctly handle a failed game history creation', () async {
    const errorMessage = 'Game history gagal dibuat';

    when(mockGameHistoryUseCase.createGameHistory(any))
        .thenThrow(Exception(errorMessage));

    await gameHistoryProvider.createGameHistory(gameHistoryEntity);

    expect(gameHistoryProvider.isLoading, false);
    expect(gameHistoryProvider.isError, true);
    expect(gameHistoryProvider.message, contains(errorMessage));
    verify(mockGameHistoryUseCase.createGameHistory(gameHistoryEntity))
        .called(1);
  });

  test('should correctly handle retrieving highest score history', () async {
    final highestScoreHistory = GameHistoryEntity(
      gameType: 'PUZZLE',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      score: 150,
    );

    when(mockGameHistoryUseCase.getHighestScoreHistory('PUZZLE'))
        .thenAnswer((_) async => highestScoreHistory);

    await gameHistoryProvider.getHighestScoreHistory('PUZZLE');

    expect(gameHistoryProvider.isLoading, false);
    expect(gameHistoryProvider.isError, false);
    expect(gameHistoryProvider.highestScoreHistory, highestScoreHistory);
    verify(mockGameHistoryUseCase.getHighestScoreHistory('PUZZLE')).called(1);
  });

  test('should correctly handle error when retrieving highest score history',
      () async {
    const errorMessage = 'Failed to retrieve highest score game history';

    when(mockGameHistoryUseCase.getHighestScoreHistory('PUZZLE'))
        .thenThrow(Exception(errorMessage));

    try {
      await gameHistoryProvider.getHighestScoreHistory('PUZZLE');
    } catch (e) {}

    expect(gameHistoryProvider.isLoading, false);
    expect(gameHistoryProvider.isError, true);
    expect(gameHistoryProvider.message, contains(errorMessage));
    verify(mockGameHistoryUseCase.getHighestScoreHistory('PUZZLE')).called(1);
  });

  test('should correctly handle setting highest score history', () {
    final highestScoreHistory = GameHistoryEntity(
      gameType: 'PUZZLE',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      score: 150,
    );

    gameHistoryProvider.setHighestScoreHistory(highestScoreHistory);

    expect(gameHistoryProvider.highestScoreHistory, highestScoreHistory);
  });
}
