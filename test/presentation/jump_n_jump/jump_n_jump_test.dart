import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame_test/flame_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/world.dart';

final jumpNJumpGameTester = FlameTester(
  JumpNJump.new,
);

void main() {
  group('JumpNJump Tests', () {
    jumpNJumpGameTester.widgetTest('Game widget can be created',
        (game, tester) async {
      expect(find.byGame<JumpNJump>(), findsOneWidget);
    });

    jumpNJumpGameTester.test('Test start position', (game) async {
      game.add(WorldGame());

      final dash = game.dash;

      final expectedPosition = Vector2(
        (game.world.size.x - dash.size.x) / 2,
        (game.world.size.y + game.screenBufferSpace) + dash.size.y,
      );

      expect(dash.position, equals(expectedPosition));
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

      expect(game.paused, isTrue);
    });
  });
}
