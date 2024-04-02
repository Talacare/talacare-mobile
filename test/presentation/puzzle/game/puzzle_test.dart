import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/game/puzzle.dart';
import 'package:talacare/presentation/puzzle/game/draggable_puzzle_piece.dart';

void main() {
  group('PuzzleWidget Tests', () {
    testWidgets('PuzzleWidget Test', (WidgetTester tester) async {
      final Widget puzzleWidget = PuzzleWidget(
        image: Image.asset(
          'assets/images/puzzle_images/perawat.png',
          height: 300,
          width: 300,
        ),
        rows: 3,
        cols: 3,
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
