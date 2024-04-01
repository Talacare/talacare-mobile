import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';

@GenerateMocks([], customMocks: [
  MockSpec<JumpNJump>(unsupportedMembers: {#lifecycle}),
])
void main() {
  group('GameManager Tests', () {
    late GameManager gameManager;

    setUp(() {
      gameManager = GameManager();
    });

    test('reset() should reset score to 0 and state to playing', () {
      gameManager.state = GameState.gameOver;
      gameManager.score.value = 10;

      gameManager.reset();

      expect(gameManager.score.value, 0);
      expect(gameManager.state, GameState.playing);
    });

    test('increaseScore() should increment the score by 1', () {
      expect(gameManager.score.value, 0);

      gameManager.increaseScore();

      expect(gameManager.score.value, 1);
    });

    test('isPlaying returns true when game state is playing', () {
      gameManager.state = GameState.playing;
      expect(gameManager.isPlaying, true);
    });

    test('isGameOver returns true when game state is gameOver', () {
      gameManager.state = GameState.gameOver;
      expect(gameManager.isGameOver, true);
    });
  });
}
