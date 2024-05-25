import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/core/utils/analytics_engine_util.dart';
import 'package:talacare/data/models/game_history_model.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:talacare/presentation/widgets/game_modal.dart';
import 'package:talacare/presentation/puzzle/state/time_left_state.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';

class NextInfo extends StatefulWidget {
  final StageState stageState;
  final AudioPlayer? audioPlayer;
  final String name;
  final String voice;
  final DateTime startTime;

  const NextInfo({
    super.key,
    required this.stageState,
    required this.name,
    required this.voice,
    this.audioPlayer,
    required this.startTime,
  });

  @override
  State<NextInfo> createState() => _NextInfoState();
}

class _NextInfoState extends State<NextInfo> {
  late AudioPlayer audioPlayer = widget.audioPlayer ?? AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final isComplete = Provider.of<CompleteState>(context);
    final timeLeftState = Provider.of<TimeLeftState>(context);
    final timePause = Provider.of<TimerState>(context);

    List<int> currentState = widget.stageState.starList;

    if (isComplete.value) {
      if (timeLeftState.value > 0) {
        currentState[widget.stageState.stage - 1] = 2;
        widget.stageState.score += (50 + timeLeftState.value);
      } else {
        currentState[widget.stageState.stage - 1] = 3;
      }

      if (widget.stageState.stage < 4) {
        currentState[widget.stageState.stage] = 1;
      }
    }

    if (!isComplete.value & !timePause.value) {
      audioPlayer.play(AssetSource('bgm.mp3'));
    } else if (timePause.value) {
      audioPlayer.stop();
    } else {
      audioPlayer.stop();
      if (timeLeftState.value > 0) {
        audioPlayer.play(AssetSource('success.wav'));
      } else if (timeLeftState.value == 0) {
        audioPlayer.play(AssetSource('game_over.wav'));
      }

      bool playVoice = true;
      audioPlayer.onPlayerComplete.listen((_) {
        if (playVoice) {
          audioPlayer.play(AssetSource(widget.voice));
          playVoice = false;
        }
      });
    }

    return Visibility(
      visible: isComplete.value,
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 300,
                height: 50,
                child: Text(
                  widget.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'Digitalt',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    shadows: [
                      Shadow(
                        // bottomLeft
                          offset: const Offset(-1.5, -1.5),
                          color: AppColors.darkPink),
                      Shadow(
                        // bottomRight
                          offset: const Offset(3.5, -1.5),
                          color: AppColors.darkPink),
                      Shadow(
                        // topRight
                          offset: const Offset(1.5, 1.5),
                          color: AppColors.darkPink),
                      Shadow(
                        // topLeft
                          offset: const Offset(-1.5, 1.5),
                          color: AppColors.darkPink),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Button(
                key: const Key('nextButton'),
                text: 'Lanjut',
                colorScheme: ButtonColorScheme.purple,
                onTap: () async {
                  audioPlayer.stop();
                  if (widget.stageState.stage < 4) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PuzzlePage(
                          stageState: StageState(
                            currentState,
                            widget.stageState.stage + 1,
                            widget.stageState.score,
                            widget.stageState.images,
                          ),
                        ),
                      ),
                    );
                  } else {
                    final gameHistory = GameHistoryModel(
                      gameType: 'PUZZLE',
                      startTime: widget.startTime,
                      endTime: DateTime.now(),
                      score: widget.stageState.score,
                    );
                    await getIt<GameHistoryProvider>()
                        .createGameHistory(gameHistory);

                    final highestScoreHistory = await getIt<GameHistoryProvider>()
                        .getHighestScoreHistory('PUZZLE');
                    final highScore = highestScoreHistory?.score ?? 0;
                    showDialog(
                      // ignore: use_build_context_synchronously
                      context: context,
                      builder: (BuildContext context) {
                        return GameModal(
                          key: const Key("game-over"),
                          currentScore: widget.stageState.score,
                          highestScore: highScore,
                          onMainLagiPressed: () {
                            AnalyticsEngineUtil.userPlaysPuzzleAgain();
                            Navigator.of(context)
                              ..pop()
                              ..pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => PuzzlePage(
                                    stageState:
                                    StageState([1, 0, 0, 0], 1, 0, []),
                                  ),
                                ),
                              );
                          },
                          onMenuPressed: () {
                            AnalyticsEngineUtil.userStopPlaysPuzzle();
                            Navigator.of(context)
                            ..pop()
                            ..pop();
                          },
                        );
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }
}
