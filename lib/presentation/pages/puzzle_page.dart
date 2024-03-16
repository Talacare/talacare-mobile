import 'package:flutter/material.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/puzzle/complete_state.dart';
import 'package:talacare/presentation/puzzle/puzzle.dart';
import 'package:talacare/presentation/puzzle/puzzle_info.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';

class PuzzlePage extends StatelessWidget {
  final StageState stageState;
  
  const PuzzlePage({super.key, required this.stageState});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerState>(
          create: (context) => TimerState(initialValue: false),
        ),
        ChangeNotifierProvider<CompleteState>(
          create: (context) => CompleteState(initialValue: false),
        ),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                PuzzleInfo(
                  stageState: stageState
                ),
                PuzzleWidget(
                  key: const Key("Image"),
                  image: Image.asset(
                    'assets/images/perawat.png',
                    height: 300,
                    width: 300,
                  ),
                  rows: 3,
                  cols: 3,
                ),
                NextInfo(
                  stageState: stageState
                ),
              ]
            ),
          ),
        )
      )
    );
  }
}
