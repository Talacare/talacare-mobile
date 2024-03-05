import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';

void main() {
  late Widget puzzlePage;

  setUp(() async {
    puzzlePage = ChangeNotifierProvider<TimerState>(
        create: (context) => TimerState(initialValue: true),
        child: const MaterialApp(home: PuzzlePage()));
  });

  testWidgets('Check if time left is showing', (tester) async {
    await tester.pumpWidget(puzzlePage);

    final findWaktu = find.text('SISA WAKTU');
    expect(findWaktu, findsOneWidget, reason: 'Time left should be visible');
  });

  testWidgets('Check if score is showing', (tester) async {
    await tester.pumpWidget(puzzlePage);

    final findSkor = find.text('TERTINGGI: 75');
    expect(findSkor, findsOneWidget, reason: 'Score should be visible');
  });

  testWidgets('Check if images is showing', (tester) async {
    await tester.pumpWidget(puzzlePage);

    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/perawat.png',
        ),
        findsOneWidget,
        reason: 'Image should be visible');
  });

  testWidgets('Check if next button is showing', (tester) async {
    await tester.pumpWidget(puzzlePage);

    final findLanjut = find.byKey(const Key('nextButton'));
    expect(findLanjut, findsOneWidget, reason: 'Next button should be visible');
  });
}
