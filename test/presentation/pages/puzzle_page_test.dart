import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';

void main() {
  group('Puzzle Page Tests', () {
    testWidgets('Check if time left is showing', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PuzzlePage()));

      final findWaktu = find.text('SISA WAKTU');
      expect(findWaktu, findsOneWidget, reason: 'Time left should be visible');
    });

    testWidgets('Check if score is showing', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PuzzlePage()));

      final findSkor = find.text('TERTINGGI: 75');
      expect(findSkor, findsOneWidget, reason: 'Score should be visible');
    });

    testWidgets('Check if images is showing', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PuzzlePage()));

      expect(
          find.byKey(const Key("Image")),
          findsOneWidget,
          reason: 'Image should be visible');
    });

    testWidgets('Check if next button is showing', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: PuzzlePage()));

      await tester.pump(const Duration(seconds: 60));

      final findLanjut = find.byKey(const Key('nextButton'));
      expect(findLanjut, findsOneWidget, reason: 'Next button should be visible');
    });
  });
}
