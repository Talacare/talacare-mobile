import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:talacare/presentation/puzzle/puzzle.dart';

void main() {
  group('Tests for PuzzleWidget', () {

    testWidgets('PuzzleWidget Creation', (WidgetTester tester) async {
      final Widget puzzleWidget = PuzzleWidget(
        image: Image.asset(
          'assets/images/perawat.png',
          height: 300,
          width: 300,
        ),
        rows: 3,
        cols: 3,
      );

      await tester.pumpWidget(MaterialApp(home: puzzleWidget));

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(ListView), findsWidgets);
    });

    testWidgets('PuzzlePiece Creation', (WidgetTester tester) async {
      final Widget puzzlePiece = PuzzlePiece(
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

      await tester.pumpWidget(MaterialApp(home: puzzlePiece));

      expect(find.byType(SizedBox), findsWidgets);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(ClipRect), findsWidgets);
      expect(find.byType(FittedBox), findsWidgets);
    });
  });

  group('Tests for PuzzleWidget State', () {
    testWidgets('PuzzleWidget State', (WidgetTester tester) async {
      final TestApp app = TestApp(
        child: PuzzleWidget(
          image: Image.asset(
            'assets/images/perawat.png',
            height: 300,
            width: 300,
          ),
          rows: 3,
          cols: 3,
        ),
      );
      await tester.pumpWidget(app);
      final state = tester.state(find.byType(PuzzleWidget));
      expect(state, isNotNull);
    });
  });
}

class TestApp extends StatelessWidget {
  final Widget child;

  const TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: child));
  }
}
