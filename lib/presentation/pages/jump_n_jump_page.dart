import 'package:flame/game.dart' hide Route;
import 'package:flutter/material.dart';
import 'package:talacare/core/enums/character_enum.dart';
import 'package:talacare/presentation/jump_n_jump/health_bar.dart';
import 'package:talacare/presentation/jump_n_jump/managers/audio_manager.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/sprites/player.dart';
import 'package:talacare/presentation/widgets/game_over_modal.dart';

class JumpNJumpPage extends StatefulWidget {
  final Character? character;
  const JumpNJumpPage({super.key, this.character});

  @override
  // ignore: library_private_types_in_public_api
  _JumpNJumpPageState createState() => _JumpNJumpPageState();
}

class _JumpNJumpPageState extends State<JumpNJumpPage> {
  late final JumpNJump game;
  final audioManager = AudioManager();

  @override
  void initState() {
    super.initState();
    game = JumpNJump(
      character: widget.character!,
      onBackToMenuCallback: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      },
      audioManager: audioManager,
    );
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
            const SizedBox(height: 10),
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
        return Text(
          'TERTINGGI: $highScore',
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          key: const Key('highScoreDisplay'),
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
              width: 24,
              height: 24,
              key: const Key('coinIcon'),
            ),
            const SizedBox(width: 8),
            Text(
              '$score',
              style: const TextStyle(
                  fontSize: 24,
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
      overlayBuilderMap: {
        'gameOverOverlay': (context, JumpNJump game) => GameOverModal(
              currentScore: game.gameManager.score.value,
              highestScore: game.gameManager.highScore.value,
              onMainLagiPressed: game.onRestartGame,
              onMenuPressed: game.onBackToMenu,
            ),
      },
      initialActiveOverlays: const [],
    );
  }
}
