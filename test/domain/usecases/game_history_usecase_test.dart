import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/domain/repositories/game_history_repository.dart';
import 'package:talacare/domain/usecases/game_history_usecase.dart';
import 'game_history_usecase_test.mocks.dart';

@GenerateMocks([GameHistoryRepository])
void main() {
  late GameHistoryUseCase useCase;
  late MockGameHistoryRepository mockGameHistoryRepository;

  final gameHistoryEntity = GameHistoryEntity(
    gameType: 'PUZZLE',
    startTime: DateTime.now(),
    endTime: DateTime.now(),
    score: 100,
  );

  setUp(() {
    mockGameHistoryRepository = MockGameHistoryRepository();
    useCase = GameHistoryUseCase(mockGameHistoryRepository);
  });

  test('should invoke createGameHistory on the game history repository',
      () async {
    when(mockGameHistoryRepository.createGameHistory(any))
        .thenAnswer(((_) async => {}));

    await useCase.createGameHistory(gameHistoryEntity);

    verify(mockGameHistoryRepository.createGameHistory(gameHistoryEntity))
        .called(1);
  });
}
