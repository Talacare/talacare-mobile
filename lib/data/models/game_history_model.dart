import 'package:talacare/domain/entities/game_history_entity.dart';

class GameHistoryModel extends GameHistoryEntity {
  const GameHistoryModel({
    required super.gameType,
    required super.score,
    required super.startTime,
    required super.endTime,
  });

  factory GameHistoryModel.fromJson(Map<String, dynamic> json) =>
      GameHistoryModel(
        gameType: json["gameType"],
        score: json["score"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
      );

  Map<String, dynamic> toJson() => {
        "gameType": gameType,
        "score": score,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
      };
}
