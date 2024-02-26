import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

import './world.dart';
import 'platform_manager.dart';
import 'sprites/sprites.dart';

enum GameState { playing, gameOver }

class JumpNJump extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  JumpNJump({super.children});

  GameState state = GameState.playing;
  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;

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

  void reset() {
    initializeGame();
    state = GameState.playing;
  }

  void onLose() {
    reset();
  }
}
