import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import './world.dart';
import 'platform_manager.dart';
import 'sprites/sprites.dart';

class JumpNJump extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  JumpNJump({super.children});

  final WorldGame world = WorldGame();
  PlatformManager platformManager = PlatformManager(
    maxVerticalDistanceToNextPlatform: 350,
  );
  Player dash = Player();

  int screenBufferSpace = 100;

  @override
  Future<void> onLoad() async {
    await add(world);

    dash.position = Vector2(
      (world.size.x - dash.size.x) / 2,
      ((world.size.y + screenBufferSpace) + dash.size.y),
    );

    await add(dash);

    await add(platformManager);

    camera.worldBounds = Rect.fromLTRB(
      0,
      -world.size.y,
      camera.gameSize.x,
      world.size.y + screenBufferSpace,
    );

    dash.megaJump();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (dash.isMovingDown) {
      camera.worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + world.size.y,
      );
    }

    var isInTopHalfOfScreen = dash.position.y <= (world.size.y / 2);
    if (!dash.isMovingDown && isInTopHalfOfScreen) {
      camera.followComponent(dash);

      camera.worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + world.size.y,
      );
    }

    if (dash.position.y >
        camera.position.y + world.size.y + dash.size.y + screenBufferSpace) {
      onLose();
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void onLose() {
    pauseEngine();
  }
}
