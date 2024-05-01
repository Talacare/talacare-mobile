import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/domain/repositories/game_history_repository.dart';

class GameHistoryUseCase {
  final GameHistoryRepository gameHistoryRepository;

  GameHistoryUseCase(this.gameHistoryRepository);

  Future<void> createGameHistory(GameHistoryEntity gameHistory) async {
    await gameHistoryRepository.createGameHistory(gameHistory);
  }

  Future<GameHistoryEntity?> getHighestScoreHistory(String gameType) async {
    return await gameHistoryRepository.getHighestScoreHistory(gameType);
  }
}
