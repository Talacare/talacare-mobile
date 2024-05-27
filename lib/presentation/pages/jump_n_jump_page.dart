import 'package:flame/game.dart' hide Route;
import 'package:flutter/material.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/jump_n_jump/health_bar.dart';
import 'package:talacare/presentation/jump_n_jump/managers/audio_manager.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/player.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/widgets/game_modal.dart';
import 'package:talacare/presentation/widgets/score_and_pause.dart';

class JumpNJumpPage extends StatefulWidget {
  final Character? character;
  const JumpNJumpPage({super.key, this.character});

  @override
  // ignore: library_private_types_in_public_api
  JumpNJumpPageState createState() => JumpNJumpPageState();
}

class JumpNJumpPageState extends State<JumpNJumpPage> {
  late final JumpNJump game;
  AudioManager audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    game = JumpNJump(character: widget.character!);
    _initializeHighestScore();
  }

  Future<void> _initializeHighestScore() async {
    final highestScoreEntity = await getIt<GameHistoryProvider>()
        .getHighestScoreHistory('JUMP_N_JUMP');
    game.gameManager.highScore.value = highestScoreEntity?.score ?? 0;
  }

  void handlePause() {
    game.gameManager.pauseGame();
    audioManager.pauseBackgroundMusic();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return GameModal(
          key: const Key("game-pause"),
          isPause: true,
          currentScore: game.gameManager.score.value,
          highestScore: game.gameManager.highScore.value,
          onMainLagiPressed: () {
            Navigator.of(context).pop();
            handleResume();
          },
          onMenuPressed: () {
            Navigator.of(context)
              ..pop()
              ..pop()
              ..pop();
          },
        );
      },
    );
  }

  void handleResume() {
    game.gameManager.resumeGame();
    audioManager.resumeBackgroundMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _createGameWidget(),
          _createScoreAndHighScore(context),
          _createControlButtons(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    audioManager.stopBackgroundMusic();
    game.dash.health.removeListener(game.onHealthChanged);
    game.gameManager.state = GameState.gameOver;
    super.dispose();
  }

  Positioned _createControlButtons() {
    return Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Listener(
            onPointerDown: (_) =>
                game.dash.handleControlButtonPress(DashDirection.left, true),
            onPointerUp: (_) =>
                game.dash.handleControlButtonPress(DashDirection.left, false),
            key: const Key('leftControlButton'),
            child: Image.asset('assets/images/jump_n_jump/left_button.png'),
          ),
          Listener(
            onPointerDown: (_) =>
                game.dash.handleControlButtonPress(DashDirection.right, true),
            onPointerUp: (_) =>
                game.dash.handleControlButtonPress(DashDirection.right, false),
            key: const Key('rightControlButton'),
            child: Image.asset('assets/images/jump_n_jump/right_button.png'),
          ),
        ],
      ),
    );
  }

  Positioned _createScoreAndHighScore(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _createScoreWidget(),
                _createHighScoreWidget(),
              ],
            ),
            const SizedBox(height: 2),
            HealthBar(
              currentValue: game.dash.health,
              maxValue: 100,
            )
          ],
        ),
      ),
    );
  }

  ValueListenableBuilder<int> _createHighScoreWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: game.gameManager.highScore,
      builder: (_, highScore, __) {
        return ScoreAndPause(
          key: const Key('highScoreDisplay'),
          highScore: highScore,
          onPauseTap: handlePause,
        );
      },
    );
  }

  ValueListenableBuilder<int> _createScoreWidget() {
    return ValueListenableBuilder<int>(
      valueListenable: game.gameManager.score,
      builder: (_, score, __) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/jump_n_jump/coin.png',
              width: 35,
              height: 35,
              key: const Key('coinIcon'),
            ),
            const SizedBox(width: 8),
            Text(
              '$score',
              style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              key: const Key('scoreDisplay'),
            ),
          ],
        );
      },
    );
  }

  GameWidget<JumpNJump> _createGameWidget() {
    return GameWidget<JumpNJump>(
      game: game,
    );
  }
}
