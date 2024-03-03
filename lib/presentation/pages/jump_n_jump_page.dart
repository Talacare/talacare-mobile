import 'package:flame/game.dart' hide Route;
import 'package:flutter/material.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/widgets/game_over_modal.dart';

class JumpNJumpPage extends StatefulWidget {
  const JumpNJumpPage({Key? key}) : super(key: key);

  @override
  _JumpNJumpPageState createState() => _JumpNJumpPageState();
}

class _JumpNJumpPageState extends State<JumpNJumpPage> {
  late final JumpNJump game;

  @override
  void initState() {
    super.initState();
    game = JumpNJump(onBackToMenuCallback: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder<int>(
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
                              color: Colors.white,
                            ),
                            key: const Key('scoreDisplay'),
                          ),
                        ],
                      );
                    },
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: game.gameManager.highScore,
                    builder: (_, highScore, __) {
                      return Text(
                        'TERTINGGI: $highScore',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        key: const Key('highScoreDisplay'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: GameWidget<JumpNJump>(
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
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => game.dash.moveLeft(),
                  child:
                      Image.asset('assets/images/jump_n_jump/left_button.png'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  key: const Key('leftControlButton'),
                ),
                ElevatedButton(
                  onPressed: () => game.dash.moveRight(),
                  child:
                      Image.asset('assets/images/jump_n_jump/right_button.png'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape:
                        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  ),
                  key: const Key('rightControlButton'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
