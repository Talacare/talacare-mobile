import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:talacare/presentation/jump_n_jump/jump_n_jump.dart';
import 'package:talacare/presentation/jump_n_jump/managers/game_manager.dart';

class JumpNJumpWidget extends StatelessWidget {
  final JumpNJump game;
  GameManager gameManager = GameManager();

  JumpNJumpWidget({Key? key})
      : game = JumpNJump(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: ValueListenableBuilder<int>(
                valueListenable: game.gameManager.score,
                builder: (_, score, __) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/jump_n_jump/coin.png',
                          width: 24, height: 24),
                      SizedBox(width: 8),
                      Text(
                        '$score',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: GameWidget<JumpNJump>(
              game: game,
              overlayBuilderMap: {
                'GameOverOverlay': (BuildContext context, JumpNJump game) {
                  return game.overlayWidgets['GameOverOverlay'] ?? SizedBox();
                },
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
                ),
                ElevatedButton(
                    onPressed: () => game.dash.moveRight(),
                    child: Image.asset(
                        'assets/images/jump_n_jump/right_button.png'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
