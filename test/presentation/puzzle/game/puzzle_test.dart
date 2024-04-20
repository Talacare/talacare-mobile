import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/game/puzzle.dart';
import 'package:talacare/presentation/puzzle/game/draggable_puzzle_piece.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';

void main() {
  group('PuzzleWidget Tests', () {
    testWidgets('PuzzleWidget Test', (WidgetTester tester) async {
      final Widget puzzleWidget = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: true),
          ),
        ],
        child: PuzzleWidget(
          image: Image.asset(
            'assets/images/puzzle_images/perawat.png',
            height: 300,
            width: 300,
          ),
          rows: 3,
          cols: 3,
        ),
      );

      await tester.pumpWidget(MaterialApp(
        home: puzzleWidget,
      ));

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(ListView), findsWidgets);

      expect(find.byType(DraggablePuzzlePiece), findsNWidgets(9));
    });
  });
}
