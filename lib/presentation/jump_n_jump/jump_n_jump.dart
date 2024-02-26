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
    // remove platform if necessary, because a new one is made each time a new
    // game is started.
    if (children.contains(platformManager)) platformManager.removeFromParent();

    // reset dash's velocity
    dash.velocity = Vector2.zero();

    //reset score

    // Setting the World Bounds for the camera will allow the camera to "move up"
    // but stay fixed horizontally, allowing Dash to go out of camera on one side,
    // and re-appear on the other side.
    camera.worldBounds = Rect.fromLTRB(
      0,
      -world.size.y, // top of screen is 0, so negative is already off screen
      camera.gameSize.x,
      world.size.y +
          screenBufferSpace, // makes sure bottom bound of game is below bottom of screen
    );
    camera.followComponent(dash);

    // move dash back to the start
    dash.position = Vector2(
      (world.size.x - dash.size.x) / 2,
      (world.size.y - dash.size.y) / 2,
    );

    // reset the the platforms
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
