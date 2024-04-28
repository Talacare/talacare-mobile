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
}
