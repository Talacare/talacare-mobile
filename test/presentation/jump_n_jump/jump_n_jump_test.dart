import 'package:flame/game.dart' hide Route;
import 'package:flame_test/flame_test.dart';
import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';
import 'package:talacare/presentation/jump_n_jump/world.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';

import 'jump_n_jump_test.mocks.dart' as JumpNJumpTestMocks;

@GenerateNiceMocks([
  MockSpec<GameHistoryProvider>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<GetIt>(onMissingStub: OnMissingStub.returnDefault),
])
@GenerateMocks([], customMocks: [
  MockSpec<IAudioManager>(as: #MockAudioManagerForJumpNJumpTest),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockAudioManager =
      JumpNJumpTestMocks.MockAudioManagerForJumpNJumpTest();

  final jumpNJumpGameTester = FlameTester(() =>
      JumpNJump(audioManager: mockAudioManager, character: Character.girl));

  late JumpNJumpTestMocks.MockGameHistoryProvider mockGameHistoryProvider;

  setUp(() async {
    mockGameHistoryProvider = JumpNJumpTestMocks.MockGameHistoryProvider();

    when(mockGameHistoryProvider.getHighestScoreHistory('JUMP_N_JUMP'))
        .thenAnswer((_) async => GameHistoryEntity(
              gameType: 'JUMP_N_JUMP',
              startTime: DateTime.now(),
              endTime: DateTime.now(),
              score: 75,
            ));

    getIt.registerSingleton<GameHistoryProvider>(mockGameHistoryProvider);
  });

  tearDown(() {
    getIt.reset();
  });

  group('JumpNJump Tests', () {
    // ignore: deprecated_member_use
    jumpNJumpGameTester.widgetTest('Game widget can be created',
        (game, tester) async {
      expect(find.byGame<JumpNJump>(), findsOneWidget);
    });

    jumpNJumpGameTester.test('Test start position', (game) async {
      game.add(WorldGame());

      final expectedPosition = Vector2(
        (game.world.size.x - game.dash.size.x) / 2,
        (game.world.size.y - game.dash.size.y) / 2,
      );

      expect(game.dash.position, equals(expectedPosition));
    });

    jumpNJumpGameTester.test('Camera updates when dash is moving down',
        (game) async {
      game.dash.velocity.y = 10;
      game.update(0.0);

      final expectedBounds = Rect.fromLTRB(
        0,
        game.camera.position.y - game.screenBufferSpace,
        game.camera.gameSize.x,
        game.camera.position.y + game.world.size.y,
      );

      expect(game.camera.worldBounds, equals(expectedBounds));
    });

    jumpNJumpGameTester.test(
        'Camera follows dash when not moving down and in top half of screen',
        (game) async {
      game.dash.position = Vector2(0, game.world.size.y / 4);
      game.update(0.0);

      final expectedBounds = Rect.fromLTRB(
        0,
        game.camera.position.y - game.screenBufferSpace,
        game.camera.gameSize.x,
        game.camera.position.y + game.world.size.y,
      );

      expect(game.camera.worldBounds, equals(expectedBounds));
    });

    jumpNJumpGameTester
        .test('Lose condition is triggered when dash is below the screen',
            (game) async {
      game.dash.position = Vector2(
          0,
          game.camera.position.y +
              game.world.size.y +
              game.dash.size.y +
              game.screenBufferSpace +
              10);
      game.update(0.0);

      game.overlays.addEntry('gameOverOverlay', (context, game) => SizedBox());
      game.overlays.add('gameOverOverlay');

      expect(game.gameManager.state, GameState.gameOver);
      expect(game.overlays.isActive('gameOverOverlay'), isTrue);
    });

    jumpNJumpGameTester.test('Game transitions to game over state correctly',
        (game) async {
      game.onLose();
      game.overlays.addEntry('gameOverOverlay', (context, game) => SizedBox());
      game.overlays.add('gameOverOverlay');

      expect(game.gameManager.state, GameState.gameOver);
      expect(game.overlays.isActive('gameOverOverlay'), isTrue);
    });

    jumpNJumpGameTester.test('Modal shown when game over', (game) async {
      game.onLose();
      game.overlays.addEntry('gameOverOverlay', (context, game) => SizedBox());
      game.overlays.add('gameOverOverlay');

      expect(game.gameManager.isGameOver, isTrue);
      expect(game.overlays.isActive('gameOverOverlay'), isTrue);
    });

    jumpNJumpGameTester.test('Game Over state is correctly triggered',
        (game) async {
      game.onLose();
      game.overlays.addEntry('gameOverOverlay', (context, game) => SizedBox());
      game.overlays.add('gameOverOverlay');

      expect(game.gameManager.isGameOver, isTrue);
      expect(game.overlays.isActive('gameOverOverlay'), isTrue);
    });

    jumpNJumpGameTester.test('Game restarts correctly', (game) async {
      game.onLose();

      game.onRestartGame();
      expect(game.overlays.isActive('gameOverOverlay'), isFalse);

      expect(game.gameManager.state, GameState.playing);
      expect(game.gameManager.score.value, 0);
    });

    jumpNJumpGameTester.test('Health decrement and automatic game over trigger',
        (game) async {
      game.dash.health.value = 5;
      await game.ready();
      await Future.delayed(const Duration(seconds: 5));
      game.update(5.0);
      expect(game.gameManager.isGameOver, isTrue);
      expect(game.overlays.isActive('gameOverOverlay'), isTrue);
    });
  });
}
