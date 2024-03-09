import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/puzzle.dart';

void main() {
  group('PuzzleWidget Tests', () {
    testWidgets('PuzzleWidget Test', (WidgetTester tester) async {
      final Widget puzzleWidget = PuzzleWidget(
        image: Image.asset(
          'assets/images/perawat.png',
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

    testWidgets('DraggablePuzzlePiece Test', (WidgetTester tester) async {
      final draggablePuzzlePiece = DraggablePuzzlePiece(
        image: Image.asset(
          'assets/images/perawat.png',
          height: 300,
          width: 300,
        ),
        rows: 3,
        cols: 3,
        rowId: 0,
        colId: 0,
        rowPos: 0,
        colPos: 0,
        onSwap: (int rowPos, int colPos, int rowPos2, int colPos2) {},
      );

      await tester.pumpWidget(MaterialApp(
        home: draggablePuzzlePiece,
      ));

      expect(find.byType(Draggable<PuzzlePiecePos>), findsOneWidget);
      expect(find.byType(DragTarget<PuzzlePiecePos>), findsOneWidget);

      expect(find.byType(PuzzlePiece), findsOneWidget);
    });

    testWidgets('PuzzlePiece Test', (WidgetTester tester) async {
      final puzzlePiece = PuzzlePiece(
        image: Image.asset(
          'assets/images/perawat.png',
          height: 300,
          width: 300,
        ),
        rows: 3,
        cols: 3,
        rowId: 0,
        colId: 0,
      );

      await tester.pumpWidget(MaterialApp(
        home: puzzlePiece,
      ));

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(ClipRect), findsWidgets);
      expect(find.byType(FittedBox), findsWidgets);
    });

    testWidgets('PuzzlePiecePos Test', (WidgetTester tester) async {
      const puzzlePiecePos = PuzzlePiecePos(rowPos: 0, colPos: 0);

      expect(puzzlePiecePos.rowPos, 0);
      expect(puzzlePiecePos.colPos, 0);
    });
  });
}
