import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/models/game_history_model.dart';

abstract class GameHistoryRemoteDatasource {
  Future<void> createGameHistory(GameHistoryModel gameHistoryModel);
  Future<GameHistoryModel> getHighestScoreHistory(String gameType);
}

class GameHistoryRemoteDatasourceImpl extends GameHistoryRemoteDatasource {
  final baseGameHistoryAPI = '${dotenv.env['API_URL']!}/game-history';
  Dio dio;
  AuthLocalDatasource localDatasource;

  GameHistoryRemoteDatasourceImpl({
    required this.dio,
    required this.localDatasource,
  });

  @override
  Future<void> createGameHistory(GameHistoryModel gameHistoryModel) async {
    try {
      final token = await localDatasource.readData('access_token');
      await dio.post(
        baseGameHistoryAPI,
        data: gameHistoryModel.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
    } on DioException catch (e) {
      var errorMessage = e.response?.data['responseMessage'];
      throw errorMessage;
    }
  }

  @override
  Future<GameHistoryModel> getHighestScoreHistory(String gameType) async {
    try {
      final token = await localDatasource.readData('access_token');
      final response = await dio.get(
        '$baseGameHistoryAPI/high-score/$gameType',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      final gameHistoryModel = GameHistoryModel.fromJson(response.data['data']);
      return gameHistoryModel;
    } on DioException catch (e) {
      var errorMessage = e.response?.data['responseMessage'];
      throw errorMessage;
    }
  }
}
