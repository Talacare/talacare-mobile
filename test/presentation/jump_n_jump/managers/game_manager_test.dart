import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';

import 'game_manager_test.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<JumpNJump>(unsupportedMembers: {#lifecycle}),
])
void main() {
  group('GameManager Tests', () {
    late GameManager gameManager;
    late JumpNJump mockJumpNJump;

    setUp(() {
      gameManager = GameManager();
      mockJumpNJump = MockJumpNJump();
      gameManager.mockGameRef(mockJumpNJump);
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

    test('pauseGame should call pauseEngine on the game', () {
      when(mockJumpNJump.pauseEngine()).thenReturn(null);
      gameManager.pauseGame();

      verify(mockJumpNJump.pauseEngine()).called(1);
      expect(gameManager.state, equals(GameState.paused));
    });

    test('pauseGame should not pause the game when state is not playing', () {
      gameManager.state = GameState.gameOver;

      gameManager.pauseGame();

      expect(gameManager.state, GameState.gameOver);
      verifyNever(mockJumpNJump.pauseEngine());
    });

    test('resumeGame should call resumeEngine on the game', () {
      when(mockJumpNJump.resumeEngine()).thenReturn(null);
      gameManager.state = GameState.paused;
      gameManager.resumeGame();

      verify(mockJumpNJump.resumeEngine()).called(1);
      expect(gameManager.state, equals(GameState.playing));
    });

    test('resumeGame should not resume the game when state is not paused', () {
      gameManager.state = GameState.playing;

      gameManager.resumeGame();

      expect(gameManager.state, GameState.playing);
      verifyNever(mockJumpNJump.resumeEngine());
    });
  });
}
