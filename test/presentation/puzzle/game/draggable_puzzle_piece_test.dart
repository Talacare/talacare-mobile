import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/game/draggable_puzzle_piece.dart';
import 'package:talacare/presentation/puzzle/game/puzzle_piece.dart';
import 'package:talacare/presentation/puzzle/game/puzzle_piece_pos.dart';

void main() {
  group('DraggablePuzzlePiece Tests', () {
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
  });
}
