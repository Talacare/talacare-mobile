import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/core/utils/text_to_speech.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/widgets/game_over_modal.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';

class NextInfo extends StatefulWidget {
  final StageState stageState;
  final AudioPlayer? audioPlayer;

  const NextInfo({
    super.key,
    required this.stageState,
    this.audioPlayer,
  });

  @override
  State<NextInfo> createState() => _NextInfoState();
}

class _NextInfoState extends State<NextInfo> {
  late AudioPlayer audioPlayer = widget.audioPlayer ?? AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final finishState = Provider.of<TimerState>(context);
    final clearState = Provider.of<CompleteState>(context);

    List<int> currentState = widget.stageState.starList;

    if (!finishState.value) {
      currentState[widget.stageState.stage - 1] = 0;

      if (widget.stageState.stage < 4) {
        currentState[widget.stageState.stage] = 1;
      }
    }

    if (clearState.value) {
      currentState[widget.stageState.stage - 1] = 2;
      if (widget.stageState.stage < 4) {
        currentState[widget.stageState.stage] = 1;
      }
    }

    if (!finishState.value && !clearState.value) {
      audioPlayer.play(AssetSource('bgm.mp3'));
    } else {
      audioPlayer.stop();

      if (clearState.value) {
        audioPlayer.play(AssetSource('success.wav'));
      } else {
        audioPlayer.play(AssetSource('game_over.wav'));
      }

      audioPlayer.onPlayerComplete.listen((_) {
        speakText(text: 'PERAWAT');
      });
    }

    return Visibility(
      visible: finishState.value | clearState.value,
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: Column(children: [
            const SizedBox(
              width: 203,
              height: 50,
              child: Text(
                'PERAWAT',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontFamily: 'Digitalt',
                    fontWeight: FontWeight.w500,
                    height: 0,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: Color(0xFFB20D78)),
                      Shadow(
                          // bottomRight
                          offset: Offset(3.5, -1.5),
                          color: Color(0xFFB20D78)),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: Color(0xFFB20D78)),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: Color(0xFFB20D78)),
                    ]),
              ),
            ),
            const SizedBox(height: 60),
            Button(
              key: const Key('nextButton'),
              text: 'Lanjut',
              colorScheme: ButtonColorScheme.purple,
              onTap: () {
                audioPlayer.stop();
                if (widget.stageState.stage < 4) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PuzzlePage(
                              stageState: StageState(
                                  currentState, widget.stageState.stage + 1),
                            )),
                  );
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return GameOverModal(
                          key: const Key("game-over"),
                          currentScore: 999,
                          highestScore: 999,
                          onMainLagiPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PuzzlePage(
                                        stageState: StageState([1, 0, 0, 0], 1),
                                      )),
                            );
                          },
                          onMenuPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          },
                        );
                      });
                }
              },
            )
          ]),
        ),
      ),
    );
  }
}
