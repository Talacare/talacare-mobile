import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/game/puzzle.dart';
import 'package:talacare/presentation/puzzle/game/draggable_puzzle_piece.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';

void main() {
  late PuzzleWidget puzzleWidget;
  late MultiProvider multiProvider;
  setUp(() {
    puzzleWidget = PuzzleWidget(
      image: Image.asset(
        'assets/images/puzzle_images/perawat.png',
        height: 300,
        width: 300,
      ),
      rows: 3,
      cols: 3,
    );

    multiProvider = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
              create: (context) => TimerState(initialValue: false)),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          )
        ],
        child: MaterialApp(
          home: puzzleWidget,
        ));

    AudioCache.instance = AudioCache(prefix: 'assets/audio/puzzle/');
  });
  group('PuzzleWidget Tests', () {
    testWidgets('Test PuzzleWidget is shown', (WidgetTester tester) async {
      await tester.pumpWidget(multiProvider);

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(ListView), findsWidgets);

      expect(find.byType(DraggablePuzzlePiece), findsNWidgets(9));
    });

    testWidgets('Test swap pieces and solving the puzzle',
        (WidgetTester tester) async {
      await tester.pumpWidget(multiProvider);

      final PuzzleWidgetState state =
          tester.state<PuzzleWidgetState>(find.byType(PuzzleWidget));
      while (!state.isGameSolved) {
        for (var i = 0; i < 3; i++) {
          for (var j = 0; j < 3; j++) {
            state.swapPieces(
                i, j, state.pieces[i][j].rowId, state.pieces[i][j].colId);
          }
        }
      }

      await tester.pump();

      expect(state.isGameSolved, isTrue);
    });
  });
}
