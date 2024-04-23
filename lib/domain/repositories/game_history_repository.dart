import 'package:talacare/domain/entities/game_history_entity.dart';

abstract class GameHistoryRepository {
  Future<void> createGameHistory(GameHistoryEntity gameHistory);
}
