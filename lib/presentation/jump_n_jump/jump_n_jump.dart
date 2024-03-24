import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/presentation/jump_n_jump/managers/audio_manager.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';

import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/jump_n_jump/managers/managers.dart';
import './world.dart';
import 'sprites/sprites.dart';

class JumpNJump extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final VoidCallback? onBackToMenuCallback;
  final Character? character;
  IAudioManager? audioManager;

  JumpNJump(
      {this.character,
      this.onBackToMenuCallback,
      this.audioManager,
      super.children});

  GameManager gameManager = GameManager();
  final WorldGame world = WorldGame();
  PlatformManager platformManager = PlatformManager(
    maxVerticalDistanceToNextPlatform: 350,
  );

  BloodBagManager bloodBagManager = BloodBagManager(
    maxVerticalDistanceToNextBloodBag: 500,
  );
  late Player dash;
  int screenBufferSpace = 100;

  @override
  Future<void> onLoad() async {
    audioManager ??= AudioManager();

    dash = Player(audioManager: audioManager!);
    dash.character = character;

    await add(world);
    await add(dash);

    initializeGame();
    startGame();
  }

  @override
  void update(double dt) {
    super.update(dt);

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

  void initializeGame() {
    if (children.contains(platformManager)) platformManager.removeFromParent();
    if (children.contains(bloodBagManager)) bloodBagManager.removeFromParent();
    dash.health = 0;
    dash.velocity = Vector2.zero();
    gameManager.score.value = 0;

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

    bloodBagManager = BloodBagManager(
      maxVerticalDistanceToNextBloodBag: 500,
    );

    add(bloodBagManager);
    add(platformManager);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void startGame() {
    audioManager!.playBackgroundMusic('jump_n_jump/jump_n_jump_bgm.mp3', 1);
    gameManager.state = GameState.playing;
    dash.megaJump();
  }

  void reset() {
    overlays.remove('gameOverOverlay');
    initializeGame();
  }

  void onLose() {
    audioManager!.playSoundEffect('jump_n_jump/game_over.wav', 1);
    audioManager!.stopBackgroundMusic();
    gameManager.state = GameState.gameOver;
    overlays.add('gameOverOverlay');
  }

  void onRestartGame() {
    reset();
    startGame();
  }

  void onBackToMenu() {
    overlays.remove('gameOverOverlay');
    onBackToMenuCallback?.call();
  }
}
