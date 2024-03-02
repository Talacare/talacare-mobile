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
}
