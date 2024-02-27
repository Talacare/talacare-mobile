import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/puzzle/puzzle_info.dart';

void main() {
  testWidgets('PuzzleInfo widget displays correct number of stars and sample answer',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PuzzleInfo()));

    expect(find.byType(Image), findsNWidgets(5));
  });

  testWidgets('PuzzleInfo widget displays correct text',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PuzzleInfo()));

    expect(find.text('TERTINGGI: 75'), findsOneWidget);
    expect(find.text('SISA WAKTU'), findsOneWidget);
  });

  testWidgets('PuzzleInfo widget displays correct image',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: PuzzleInfo()));

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
    await tester.pumpWidget(const MaterialApp(home: PuzzleInfo()));

    expect(find.byType(Column), findsNWidgets(3));
    expect(find.byType(Row), findsNWidgets(3));
    expect(find.byType(Container), findsNWidgets(3));
  });
}
