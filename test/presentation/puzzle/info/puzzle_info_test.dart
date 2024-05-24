import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:talacare/data/models/image_pair.dart';

import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/info/puzzle_info.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';
import 'package:talacare/presentation/puzzle/state/time_left_state.dart';

void main() {
  late Widget puzzleInfo;
  late List<ImagePair> image;
  const highestScore = 100;

  setUp(() async {
    image = [
      ImagePair("assets/images/puzzle_images/jantung.png", "JANTUNG", "voices/jantung.mp3"),
      ImagePair(
          "assets/images/puzzle_images/kantongdarah.png", "KANTONG DARAH", "voices/kantongdarah.mp3"),
      ImagePair("assets/images/puzzle_images/masker.png", "MASKER", "voices/masker.mp3"),
      ImagePair("assets/images/puzzle_images/perawat.png", "PERAWAT", "voices/perawat.mp3"),
    ];

    StageState state = StageState([1, 2, 3, 0], 4, 0, image);

    puzzleInfo = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: false),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: MaterialApp(
          home: PuzzleInfo(
            stageState: state,
            highestScore: highestScore,
          ),
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

    expect(find.text('TERTINGGI: $highestScore'), findsOneWidget);
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
                  "assets/images/puzzle_images/perawat.png",
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

  testWidgets('PuzzleInfo widget change image star to lose image',
      (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: true),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: MaterialApp(
          home: PuzzleInfo(
            stageState: StageState([0, 0, 0, 0], 4, 0, image),
            highestScore: highestScore,
          ),
        )));

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

  testWidgets('PuzzleInfo widget change image star to win image',
      (WidgetTester tester) async {
    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: false),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: true),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: MaterialApp(
          home: PuzzleInfo(
            stageState: StageState([0, 0, 0, 0], 4, 0, image),
            highestScore: highestScore,
          ),
        )));

    expect(
        find.byWidgetPredicate(
          (Widget widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName ==
                  'assets/images/puzzle_star/star_win.png',
        ),
        findsOneWidget);
  });
}
