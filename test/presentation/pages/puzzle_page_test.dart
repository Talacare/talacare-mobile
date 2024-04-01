import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';

void main() {
  late Widget puzzlePage;

  setUp(() async {
    puzzlePage = MaterialApp(
          home: PuzzlePage(stageState: StageState([1, 0, 0, 0], 1, 0, []),
        ));
  });
  
  group('Puzzle Page Tests', () {

    testWidgets('Check if time left is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        final findWaktu = find.text('SISA WAKTU');
        expect(findWaktu, findsOneWidget, reason: 'Time left should be visible');
      });
    });

    testWidgets('Check if score is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        final findSkor = find.text('TERTINGGI: 75');
        expect(findSkor, findsOneWidget, reason: 'Score should be visible');
      });
    });

    testWidgets('Check if images is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();

        expect(find.byKey(const Key("Image")), findsOneWidget,
            reason: 'Image should be visible');
      });
      
    });

    testWidgets('Check if next button is showing', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(puzzlePage);
        await tester.pumpAndSettle();
        await tester.pump(const Duration(seconds: 60));

        final findLanjut = find.byKey(const Key('nextButton'));
        expect(findLanjut, findsOneWidget,
            reason: 'Next button should be visible');
      });
    });
  });
}
