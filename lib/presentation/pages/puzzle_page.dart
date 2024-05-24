import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/data/models/image_pair.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/injection.dart';
import 'package:talacare/presentation/providers/game_history_provider.dart';
import 'package:talacare/presentation/puzzle/game/puzzle.dart';
import 'package:talacare/presentation/puzzle/info/puzzle_info.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';
import 'package:talacare/presentation/puzzle/state/time_left_state.dart';

class PuzzlePage extends StatelessWidget {
  final StageState stageState;

  const PuzzlePage({super.key, required this.stageState});

  @override
  Widget build(BuildContext context) {
    AudioCache.instance = AudioCache(prefix: 'assets/audio/puzzle/');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimerState>(
          create: (context) => TimerState(initialValue: false),
        ),
        ChangeNotifierProvider<CompleteState>(
          create: (context) => CompleteState(initialValue: false),
        ),
        ChangeNotifierProvider<TimeLeftState>(
          create: (context) => TimeLeftState(initialValue: 60),
        ),
      ],
      child: FutureBuilder<List<ImagePair>>(
        future: stageState.generateImages(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            ImagePair imagePair = stageState.images[stageState.stage - 1];
            String image = imagePair.image;
            String name = imagePair.name;
            String voice = imagePair.voice;

            return FutureBuilder<GameHistoryEntity?>(
                future: getIt<GameHistoryProvider>()
                    .getHighestScoreHistory('PUZZLE'),
                builder: (context, snapshot) {
                  final highestScore = snapshot.data?.score ?? 0;
                  return Scaffold(
                    body: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          children: [
                            PuzzleInfo(
                              stageState: stageState,
                              highestScore: highestScore,
                            ),
                            PuzzleWidget(
                              key: const Key("Image"),
                              image: Image.asset(
                                image,
                                height: 300,
                                width: 300,
                              ),
                              rows: 3,
                              cols: 3,
                            ),
                            NextInfo(
                              name: name,
                              voice: voice,
                              stageState: stageState,
                              startTime: DateTime.now(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
