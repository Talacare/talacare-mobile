import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/info/puzzle_info.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';

void main() {
  late Widget puzzleInfo;

  setUp(() async {
    puzzleInfo = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: true),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
        ],
        child: MaterialApp(
          home: PuzzleInfo(stageState: StageState([1, 2, 3, 0], 4)),
        ));
  });

  testWidgets(
      'PuzzleInfo widget displays correct number of stars and sample answer',
      (WidgetTester tester) async {
    await tester.pumpWidget(puzzleInfo);

    expect(find.byType(Image), findsNWidgets(5));
  });

  testWidgets('PuzzleInfo widget displays correct text',
      (WidgetTester tester) async {
    await tester.pumpWidget(puzzleInfo);

    expect(find.text('TERTINGGI: 75'), findsOneWidget);
    expect(find.text('SISA WAKTU'), findsOneWidget);
  });

  testWidgets('PuzzleInfo widget displays correct image',
      (WidgetTester tester) async {
    await tester.pumpWidget(puzzleInfo);

    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/perawat.png',
        ),
        findsOneWidget);
  });

  testWidgets('PuzzleInfo widget layout test', (WidgetTester tester) async {
    await tester.pumpWidget(puzzleInfo);

    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(Row), findsNWidgets(3));
    expect(find.byType(Container), findsNWidgets(3));
  });

  testWidgets('PuzzleInfo widget displays correct star image',
      (WidgetTester tester) async {
    await tester.pumpWidget(puzzleInfo);

    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/puzzle_star/star_border.png',
        ),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/puzzle_star/star_border_glow.png',
        ),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/puzzle_star/star_win.png',
        ),
        findsOneWidget);

    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/puzzle_star/star_lose.png',
        ),
        findsOneWidget);
  });
}
