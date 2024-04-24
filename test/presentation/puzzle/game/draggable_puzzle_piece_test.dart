import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/game/draggable_puzzle_piece.dart';
import 'package:talacare/presentation/puzzle/game/puzzle_piece.dart';
import 'package:talacare/presentation/puzzle/game/puzzle_piece_pos.dart';

void main() {
  late Widget draggablePuzzlePiece;

  setUp(() async {
    draggablePuzzlePiece = DraggablePuzzlePiece(
        image: Image.asset(
          'assets/images/puzzle_images/perawat.png',
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
  });

  group('DraggablePuzzlePiece Tests', () {
    testWidgets('DraggablePuzzlePiece Load All Component', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: draggablePuzzlePiece,
      ));

      expect(find.byType(Draggable<PuzzlePiecePos>), findsOneWidget);
      expect(find.byType(DragTarget<PuzzlePiecePos>), findsOneWidget);

      expect(find.byType(PuzzlePiece), findsOneWidget);
    });

    testWidgets('DraggablePuzzlePiece Can Drag Puzzle', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: draggablePuzzlePiece,
      ));

      final Offset firstLocation = tester.getCenter(find.byType(PuzzlePiece));
      final TestGesture gesture = await tester.startGesture(firstLocation, pointer: 7);
      await tester.pump();

      final Offset secondLocation = tester.getCenter(find.byType(PuzzlePiece));
      await gesture.moveTo(secondLocation);
      await tester.pump();

      await gesture.up();
      await tester.pump();

      expect(find.byType(PuzzlePiece), findsOneWidget);
    });

    testWidgets('DraggablePuzzlePiece onLeave Firing', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: draggablePuzzlePiece,
      ));

      final Offset firstLocation = tester.getCenter(find.byType(DragTarget<PuzzlePiecePos>));
      final TestGesture gesture = await tester.startGesture(firstLocation, pointer: 7);
      await tester.pump();

      final Offset secondLocation = tester.getCenter(find.byType(PuzzlePiece));
      await gesture.moveTo(secondLocation);
      await tester.pump();

      await gesture.up();
      await tester.pump();

      expect(find.byType(PuzzlePiece), findsOneWidget);
    });
  });
}
