import 'package:flutter/material.dart';
import 'package:talacare/core/enums/button_color_scheme_enum.dart';
import 'package:talacare/presentation/pages/home_page.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';
import 'package:talacare/presentation/widgets/button.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';
import 'package:talacare/presentation/widgets/game_over_modal.dart';

class NextInfo extends StatefulWidget {
  const NextInfo({super.key});

  @override
  State<NextInfo> createState() => _NextInfoState();
}

class _NextInfoState extends State<NextInfo> {

  @override
  Widget build(BuildContext context) {
    final finishState = Provider.of<TimerState>(context);
    
    return Visibility(
      visible: finishState.value,
      child: Container(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Center(
          child: Column(children: [
            const SizedBox(
              width: 203,
              height: 50,
              child: Text(
                'SUSTER',
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
                showDialog(context: context, builder: (BuildContext context){
                return
                  GameOverModal(
                    currentScore: 999,
                    highestScore: 999,
                    onMainLagiPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PuzzlePage()),
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
              },
            )
          ]),
        ),
      ),
    );
  }
}
