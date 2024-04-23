import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/models/game_history_model.dart';

abstract class GameHistoryRemoteDatasource {
  Future<void> createGameHistory(GameHistoryModel gameHistoryModel);
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
  Future<void> createGameHistory(GameHistoryModel gameHistoryModel) async {}
}
