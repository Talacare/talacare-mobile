import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/puzzle_page.dart';

void main() {
  late Widget puzzlePage;

  setUp(() async {
    puzzlePage = const MaterialApp(
      home: PuzzlePage(),
    );
  });

  testWidgets('Check sisa waktu muncul', (tester) async {
    await tester.pumpWidget(puzzlePage);

    final findWaktu = find.text('SISA WAKTU');
    expect(findWaktu, findsOneWidget, reason: 'Sisa waktu harus muncul');
  });

  testWidgets('Check skor muncul', (tester) async {
    await tester.pumpWidget(puzzlePage);

    final findSkor = find.text('TERTINGGI: 75');
    expect(findSkor, findsOneWidget, reason: 'Skor harus muncul');
  });

  testWidgets('Check gambar muncul', (tester) async {
    await tester.pumpWidget(puzzlePage);

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

  testWidgets('Check tombol lanjut muncul', (tester) async {
    await tester.pumpWidget(puzzlePage);

    final findLanjut = find.byKey(const Key('nextButton'));
    expect(findLanjut, findsOneWidget, reason: 'Tombol lanjut muncul');
  });
}
