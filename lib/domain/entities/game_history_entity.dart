import 'package:equatable/equatable.dart';

class GameHistoryEntity extends Equatable {
  const GameHistoryEntity({
    required this.gameType,
    required this.startTime,
    required this.endTime,
    required this.score,
  });

  final String gameType;
  final DateTime startTime;
  final DateTime endTime;
  final int score;

  @override
  List<Object?> get props => [gameType, startTime, endTime, score];
}
