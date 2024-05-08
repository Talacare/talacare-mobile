import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart';

import 'player_test.mocks.dart';
import 'package:talacare/core/enums/character_enum.dart';

@GenerateMocks([], customMocks: [
  MockSpec<IAudioManager>(as: #MockAudioManagerForPlayerTest),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final mockAudioManager = MockAudioManagerForPlayerTest();
  final jumpNJumpGameTester = FlameTester(() =>
      JumpNJump(character: Character.boy, audioManager: mockAudioManager));

  setUp(() {
    reset(mockAudioManager);
  });

  group('Player Tests', () {
    jumpNJumpGameTester.test('Test Player movement to left', (game) async {
      game.dash.handleControlButtonPress(DashDirection.left, true);
      game.update(0.1);

      expect(
          game.dash.current,
          equals(PlayerState(
            isMoving: true,
            isMovingDown: false,
            isLowHealth: false,
          )));
      expect(game.dash.velocity.x, lessThan(0));

      game.dash.handleControlButtonPress(DashDirection.left, false);
    });

    jumpNJumpGameTester.test('Test Player movement to right', (game) async {
      game.dash.handleControlButtonPress(DashDirection.right, true);
      game.update(0.1);

      expect(
          game.dash.current,
          equals(PlayerState(
            isMoving: true,
            isMovingDown: false,
            isLowHealth: false,
          )));
      expect(game.dash.velocity.x, greaterThan(0));

      game.dash.handleControlButtonPress(DashDirection.right, false);
    });

    jumpNJumpGameTester.test('Test Player Colliding Platform', (game) async {
      game.dash.velocity = Vector2(0, 10);

      final intersectionPoints = {Vector2(10, 10)};
      Platform platform = Platform();
      platform.position.y = game.dash.position.y + game.dash.size.y / 2 - 25;
      game.dash.onCollision(intersectionPoints, platform);

      expect(game.dash.velocity.y, -game.dash.jumpSpeed);
    });

    jumpNJumpGameTester.test('Test Player Jump Plays Sound Effect',
        (game) async {
      game.dash.jump();

      verify(mockAudioManager.playSoundEffect(
              'jump_n_jump/jump_on_platform.wav', 1))
          .called(1);
    });

    jumpNJumpGameTester
        .test('Player X position is reset when moving out of right bounds',
            (game) async {
      final player = Player(character: Character.girl);
      player.size = Vector2(70, 120);
      await game.ensureAdd(player);
      player.position.x = game.size.x + player.size.x / 2 + 1;
      game.update(0.1);
      expect(player.position.x, equals(-(player.size.x / 2)));
    });

    jumpNJumpGameTester.test(
        'Test Player Collecting Blood Bag and Health increased', (game) async {
      game.dash.velocity = Vector2(0, 10);
      final intersectionPoints = {Vector2(10, 10)};
      bool isCollidingVertically =
          (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;
      game.dash.onCollision(intersectionPoints, BloodBag());
      expect(isCollidingVertically, isTrue);

      game.dash.health.value = 90.0;
      final initialHealth = game.dash.health.value;
      game.dash.increaseHealth(7);
      expect(game.dash.health.value, lessThanOrEqualTo(100.0));
      expect(game.dash.health.value, equals(initialHealth + 7));
    });

    jumpNJumpGameTester.test('Test Player Health Decreased', (game) async {
      game.dash.health.value = 50.0;
      game.dash.decreaseHealth(10.0);
      expect(game.dash.health.value, equals(40.0));
    });

    jumpNJumpGameTester.test('Test Player Move Speed Reduced When Low Health',
        (game) async {
      game.dash.health.value = 20.0;
      game.dash.moveSpeed = Player.originalMoveSpeed;
      game.update(0.1);

      expect(game.dash.current?.isLowHealth, isTrue);
      expect(
          game.dash.moveSpeed,
          equals(
              Player.originalMoveSpeed * Player.lowHealthMoveSpeedMultiplier));
    });

    jumpNJumpGameTester.test('Test Player Jump Speed Reduced When Low Health',
        (game) async {
      game.dash.health.value = 20.0;
      game.dash.jumpSpeed = Player.originalJumpSpeed;
      game.update(0.1);
      game.dash.jump();

      expect(game.dash.current?.isLowHealth, isTrue);
      expect(
          game.dash.velocity.y,
          equals(
              -Player.originalJumpSpeed * Player.lowHealthJumpSpeedMultiplier));
    });

    jumpNJumpGameTester.test(
        'Test Player Mega Jump Speed Reduced When Low Health', (game) async {
      game.dash.health.value = 20.0;
      game.dash.jumpSpeed = Player.originalJumpSpeed;
      game.update(0.1);
      game.dash.megaJump();

      expect(game.dash.current?.isLowHealth, isTrue);
      expect(
          game.dash.velocity.y,
          equals(-Player.originalJumpSpeed *
              Player.megaJumpSpeedMultiplier *
              Player.lowHealthJumpSpeedMultiplier));
    });

    jumpNJumpGameTester.test('Test Player Velocity Calculation', (game) async {
      game.dash.moveSpeed = 200.0;
      game.dash.hAxisInput = 1;
      game.dash.update(0.1);

      expect(game.dash.velocity.x, equals(0));
    });

    jumpNJumpGameTester
        .test('Test Player X Position Reset When Moving Out of Left Bounds',
            (game) async {
      game.dash.position.x = -(game.dash.size.x / 2) - 1;
      game.update(0.1);

      expect(game.dash.position.x, equals(game.size.x + game.dash.size.x / 2));
    });

    jumpNJumpGameTester
        .test('Test Player X Position Reset When Moving Out of Right Bounds',
            (game) async {
      game.dash.position.x = game.size.x + game.dash.size.x / 2 + 1;
      game.update(0.1);

      expect(game.dash.position.x, equals(-(game.dash.size.x / 2)));
    });

    jumpNJumpGameTester.test('Test Player Mega Jump Velocity', (game) async {
      game.dash.jumpSpeed = 500.0;
      game.dash.megaJump();

      expect(game.dash.velocity.y,
          equals(-500.0 * Player.megaJumpSpeedMultiplier));
    jumpNJumpGameTester.test('Test Player Velocity on GameOver', (game) async {
      game.dash.isGameOver = true;
      game.dash.update(0.1);
      expect(game.dash.velocity, equals(Vector2(0, 500)));
    });

    jumpNJumpGameTester.test('Test Player Ignores Platform on GameOver', (game) async {
      game.dash.velocity = Vector2(0, 10);
      game.dash.isGameOver = true;

      final intersectionPoints = {Vector2(10, 10)};
      Platform platform = Platform();
      platform.position.y = game.dash.position.y + game.dash.size.y / 2 - 25;
      game.dash.onCollision(intersectionPoints, platform);
      game.dash.update(0.1);
      
      expect(game.dash.velocity, equals(Vector2(0, 500)));
    });

    jumpNJumpGameTester.test('Test Player onLoad creates sprites', (game) async {
      game.dash.onLoad();
      
      expect(game.dash.sprites!.length, equals(8));
    });
  });
}
