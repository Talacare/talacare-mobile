import 'package:talacare/data/datasources/game_history_remote_datasource.dart';
import 'package:talacare/data/models/game_history_model.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/domain/repositories/game_history_repository.dart';

class GameHistoryRepositoryImpl extends GameHistoryRepository {
  final GameHistoryRemoteDatasource gameHistoryRemoteDatasource;

  GameHistoryRepositoryImpl(this.gameHistoryRemoteDatasource);

  @override
  Future<void> createGameHistory(GameHistoryEntity gameHistory) async {
    if (gameHistory is GameHistoryModel) {
      await gameHistoryRemoteDatasource.createGameHistory(gameHistory);
    }
  }

  @override
  Future<GameHistoryEntity?> getHighestScoreHistory(String gameType) async {
    return await gameHistoryRemoteDatasource.getHighestScoreHistory(gameType);
  }
}
