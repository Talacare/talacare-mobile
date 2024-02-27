import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';

import './world.dart';
import 'managers/platform_manager.dart';
import 'sprites/sprites.dart';

class JumpNJump extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  JumpNJump({super.children});

  GameManager gameManager = GameManager();

  final WorldGame world = WorldGame();
  PlatformManager platformManager = PlatformManager(
    maxVerticalDistanceToNextPlatform: 350,
  );
  Player dash = Player();

  int screenBufferSpace = 100;

  @override
  Future<void> onLoad() async {
    await add(world);

    await add(dash);

    initializeGame();
    dash.megaJump();
  }

  void initializeGame() {
    if (children.contains(platformManager)) platformManager.removeFromParent();

    dash.velocity = Vector2.zero();

    camera.worldBounds = Rect.fromLTRB(
      0,
      -world.size.y,
      camera.gameSize.x,
      world.size.y + screenBufferSpace,
    );
    camera.followComponent(dash);

    dash.position = Vector2(
      (world.size.x - dash.size.x) / 2,
      (world.size.y - dash.size.y) / 2,
    );

    platformManager = PlatformManager(
      maxVerticalDistanceToNextPlatform: 350,
    );
    add(platformManager);
  }

  @override
  void update(double dt) {
    super.update(dt);

    //Tambahan state jika game over
    if (gameManager.isGameOver) {
      return;
    }

    if (gameManager.isPlaying) {
      final Rect worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + world.size.y,
      );

      if (dash.isMovingDown) {
        camera.worldBounds = worldBounds;
      }

      var isInTopHalfOfScreen = dash.position.y <= (world.size.y / 2);
      if (!dash.isMovingDown && isInTopHalfOfScreen) {
        camera.followComponent(dash);

        camera.worldBounds = worldBounds;
      }

      if (dash.position.y >
          camera.position.y + world.size.y + dash.size.y + screenBufferSpace) {
        onLose();
      }
    }
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void reset() {
    gameManager.state = GameState.playing;
    dash.removeFromParent();
    overlays.add('gameOverOverlay');
  }

  // //D Commented for implementation change
  void onLose() {
    reset();
  }
}
