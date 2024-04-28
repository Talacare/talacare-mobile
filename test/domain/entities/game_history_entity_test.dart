import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';

void main() {
  const gameType = 'PUZZLE';
  final startTime = DateTime(2023, 1, 1);
  final endTime = DateTime(2023, 1, 2);
  const score = 100;

  final gameHistory = GameHistoryEntity(
    gameType: gameType,
    startTime: startTime,
    endTime: endTime,
    score: score,
  );

  test('GameHistoryEntity instances with the same properties should be equal',
      () {
    final otherGameHistory = GameHistoryEntity(
      gameType: gameType,
      startTime: startTime,
      endTime: endTime,
      score: score,
    );

    expect(gameHistory, equals(otherGameHistory));
  });

  test(
      'GameHistoryEntity instances with different properties should not be equal',
      () {
    final otherGameHistory = GameHistoryEntity(
      gameType: 'JUMP_N_JUMP',
      startTime: startTime,
      endTime: endTime,
      score: 200,
    );

    expect(gameHistory, isNot(equals(otherGameHistory)));
  });

  test('GameHistoryEntity should generate correct list of props', () {
    expect(gameHistory.props, equals(['PUZZLE', startTime, endTime, 100]));
  });
}
