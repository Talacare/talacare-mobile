import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/game/puzzle_piece.dart';

void main() {
  group('PuzzlePiece Tests', () {
    testWidgets('PuzzlePiece Test', (WidgetTester tester) async {
      final puzzlePiece = PuzzlePiece(
        image: Image.asset(
          'assets/images/puzzle_images/perawat.png',
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
  });
}
