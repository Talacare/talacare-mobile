import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';

class GameManager extends Component with HasGameRef<JumpNJump> {
  GameManager();

  ValueNotifier<int> score = ValueNotifier(0);
  ValueNotifier<int> highScore = ValueNotifier<int>(0);

  DateTime? startTime;

  GameState state = GameState.playing;

  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;

  void reset() {
    score.value = 0;
    state = GameState.playing;
  }

  void increaseScore() {
    score.value += 1;
  }

  void pauseGame() {
    if (state == GameState.playing) {
      state = GameState.paused;
      gameRef.pauseEngine();
    }
  }

  void resumeGame() {
    if (state == GameState.paused) {
      state = GameState.playing;
      gameRef.resumeEngine();
    }
  }
}

enum GameState { playing, gameOver, paused }
