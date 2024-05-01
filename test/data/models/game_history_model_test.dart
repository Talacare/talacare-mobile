import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/data/models/game_history_model.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';

void main() {
  const gameType = 'PUZZLE';
  const startTime = '2023-01-01T00:00:00.000';
  const endTime = '2023-01-02T00:00:00.000';
  const score = 100;

  final gameHistoryModel = GameHistoryModel(
    gameType: gameType,
    startTime: DateTime.parse(startTime),
    endTime: DateTime.parse(endTime),
    score: score,
  );

  const json = {
    'gameType': gameType,
    'startTime': '2023-01-01T00:00:00.000',
    'endTime': '2023-01-02T00:00:00.000',
    'score': score,
  };

  test('Initialization', () {
    expect(gameHistoryModel.gameType, gameType);
    expect(gameHistoryModel.startTime, DateTime.parse(startTime));
    expect(gameHistoryModel.endTime, DateTime.parse(endTime));
    expect(gameHistoryModel.score, score);
  });

  test('should be a subclass of GameHistoryEntity', () async {
    expect(gameHistoryModel, isA<GameHistoryEntity>());
  });

  test('Serialization to JSON', () {
    final generatedJson = gameHistoryModel.toJson();
    expect(generatedJson['gameType'], gameType);
    expect(generatedJson['startTime'], startTime);
    expect(generatedJson['endTime'], endTime);
    expect(generatedJson['score'], score);
  });

  test('Deserialization from JSON', () {
    final deserializedModel = GameHistoryModel.fromJson(json);
    expect(deserializedModel.gameType, gameType);
    expect(deserializedModel.startTime, DateTime.parse(startTime));
    expect(deserializedModel.endTime, DateTime.parse(endTime));
    expect(deserializedModel.score, score);
  });

  test('Deserialization from incomplete JSON', () {
    bool didThrowException = false;
    final incompleteJson = {'gameType': gameType, 'startTime': startTime};

    try {
      GameHistoryModel.fromJson(incompleteJson);
    } catch (e) {
      didThrowException = true;
    }
    expect(didThrowException, isTrue);
  });
}
