import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:talacare/presentation/puzzle/puzzle_info.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerState>(
        create: (context) => TimerState(initialValue: false),
        child: const Scaffold(
            body: SingleChildScrollView(
          child: Column(children: [
            PuzzleInfo(),
            Gap(500),
            NextInfo(),
          ]),
        )));
  }
}
