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

    jumpNJumpGameTester.test(
        'Test Player Collecting Blood Bag and Health increased', (game) async {
      game.dash.velocity = Vector2(0, 10);
      final initialHealth = game.dash.health;
      final intersectionPoints = {Vector2(10, 10)};
      bool isCollidingVertically =
          (intersectionPoints.first.y - intersectionPoints.last.y).abs() < 5;
      game.dash.onCollision(intersectionPoints, BloodBag());
      expect(game.dash.health, initialHealth + 7);
      expect(isCollidingVertically, isTrue);
    });
  });
}
