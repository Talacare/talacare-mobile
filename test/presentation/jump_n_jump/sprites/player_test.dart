import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/sprites.dart';

final jumpNJumpGameTester = FlameTester(
  JumpNJump.new,
);

void main() {
  group('Player Tests', () {
    TestWidgetsFlutterBinding.ensureInitialized();

    jumpNJumpGameTester.test('Test Player movement to left', (game) async {
      game.dash.handleControlButtonPress(DashDirection.left, true);
      game.update(0.1);

      expect(game.dash.current, equals(DashDirection.left));
      expect(game.dash.velocity.x, lessThan(0));

      game.dash.handleControlButtonPress(DashDirection.left, false);
    });

    jumpNJumpGameTester.test('Test Player movement to right', (game) async {
      game.dash.handleControlButtonPress(DashDirection.right, true);
      game.update(0.1);

      expect(game.dash.current, equals(DashDirection.right));
      expect(game.dash.velocity.x, greaterThan(0));

      game.dash.handleControlButtonPress(DashDirection.right, false);
    });

    jumpNJumpGameTester.test('Test Player Colliding Platform', (game) async {
      game.dash.velocity = Vector2(0, 10);

      final intersectionPoints = {Vector2(10, 10)};
      bool isCollidingVertically =
          (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;
      game.dash.onCollision(intersectionPoints, Platform());

      expect(isCollidingVertically, isTrue);
      expect(game.dash.velocity.y, -game.dash.jumpSpeed);
    });

    jumpNJumpGameTester
        .test('Player X position is reset when moving out of right bounds',
            (game) async {
      final player = Player();
      player.size = Vector2(70, 120);
      await game.ensureAdd(player);
      player.position.x = game.size.x + player.size.x + 11;
      game.update(0.1);
      expect(player.position.x, equals(player.size.x / 2));
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
  });
}
