import 'dart:async';

import 'package:flame/components.dart' as flame_components;
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:talacare/data/models/game_history_model.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/jump_n_jump/interface/audio_manager_interface.dart';
import 'package:talacare/presentation/jump_n_jump/managers/audio_manager.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/jump_n_jump/managers/food_manager.dart';
import 'package:talacare/presentation/jump_n_jump/managers/managers.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/widgets/game_over_modal.dart';
import './world.dart';
import 'sprites/sprites.dart';

class JumpNJump extends FlameGame
    with HasKeyboardHandlerComponents, HasCollisionDetection {
  final Character? character;
  IAudioManager? audioManager;

  JumpNJump({
    this.character,
    this.audioManager,
    super.children,
  });

  GameManager gameManager = GameManager();
  final WorldGame world = WorldGame();
  PlatformManager platformManager = PlatformManager();

  BloodBagManager bloodBagManager = BloodBagManager();
  FoodManager foodManager = FoodManager();
  Player dash = Player();
  int screenBufferSpace = 100;

  @override
  Future<void> onLoad() async {
    audioManager ??= AudioManager();

    dash.character = character;
    dash.audioManager = audioManager;

    await add(world);
    await add(dash);

    dash.health.addListener(onHealthChanged);

    initializeGame();
    startGame();
  }

  void onHealthChanged() {
    if (dash.health.value <= 0) {
      onLose();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (gameManager.isGameOver) {
      return;
    }

    if (gameManager.isPlaying) {
      camera.worldBounds = Rect.fromLTRB(
        0,
        camera.position.y - screenBufferSpace,
        camera.gameSize.x,
        camera.position.y + world.size.y,
      );

      if (dash.position.y >
          camera.position.y + world.size.y + dash.size.y + screenBufferSpace) {
        dash.health.value = 0;
        onLose();
      }
    }
  }

  void initializeGame() {
    if (children.contains(platformManager)) platformManager.removeFromParent();
    if (children.contains(bloodBagManager)) bloodBagManager.removeFromParent();
    if (children.contains(foodManager)) foodManager.removeFromParent();
    dash.health.value = 100;
    dash.velocity = Vector2.zero();
    dash.isGameOver = false;
    gameManager.score.value = 0;

    camera.worldBounds = Rect.fromLTRB(
      0,
      0.0 - screenBufferSpace,
      camera.gameSize.x,
      world.size.y,
    );
    const relativeOffset = flame_components.Anchor(0.5, 0.4);
    camera.followComponent(dash, relativeOffset: relativeOffset);

    dash.position = Vector2(
      (world.size.x - dash.size.x) / 2,
      (world.size.y - dash.size.y) / 2,
    );

    platformManager = PlatformManager();
    bloodBagManager = BloodBagManager();
    foodManager = FoodManager();

    add(platformManager);
    add(bloodBagManager);
    add(foodManager);
  }

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 241, 247, 249);
  }

  void startGame() {
    if (audioManager != null) {
      audioManager!.playBackgroundMusic('jump_n_jump/jump_n_jump_bgm.mp3', 1);
    }
    gameManager.state = GameState.playing;
    gameManager.startTime = DateTime.now();
    dash.megaJump();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (gameManager.isGameOver) {
        timer.cancel();
      } else {
        dash.decreaseHealth(2);
      }
    });
  }

  void reset() {
    overlays.remove('gameOverOverlay');
    initializeGame();
  }

  void onLose() async {
    dash.isGameOver = true;

    if (audioManager != null) {
      audioManager!.playSoundEffect('jump_n_jump/game_over.wav', 1);
      audioManager!.stopBackgroundMusic();
    }
    gameManager.state = GameState.gameOver;

    final gameHistory = GameHistoryModel(
      gameType: 'JUMP_N_JUMP',
      startTime: gameManager.startTime!,
      endTime: DateTime.now(),
      score: gameManager.score.value,
    );
    await getIt<GameHistoryProvider>().createGameHistory(gameHistory);

    final highestScoreHistory = await getIt<GameHistoryProvider>()
        .getHighestScoreHistory('JUMP_N_JUMP');
    gameManager.highScore.value = highestScoreHistory?.score ?? 0;

    overlays.addEntry(
      'gameOverOverlay',
      (context, game) => GameOverModal(
        currentScore: gameManager.score.value,
        highestScore: gameManager.highScore.value,
        onMainLagiPressed: onRestartGame,
        onMenuPressed: () {
          onBackToMenu(context);
        },
      ),
    );
    overlays.add('gameOverOverlay');
  }

  void onRestartGame() {
    reset();
    startGame();
  }

  void onBackToMenu(BuildContext context) {
    overlays.remove('gameOverOverlay');
    Navigator.of(context)
      ..pop()
      ..pop();
  }
}
