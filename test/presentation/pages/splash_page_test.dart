import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/splash_page_dart.dart';

void main() {
  group('End-to-End Test for Splash Page', () {
    const int delayDurationSeconds = 3;
    late Widget splashPage;

    setUp(() {
      splashPage = const MaterialApp(
        home: SplashPage(),
      );
    });

    testWidgets('Verify the TalaCare logo is showing', (tester) async {
      await tester.pumpWidget(splashPage);
      await tester.pump(const Duration(seconds: delayDurationSeconds));

      final findLogo = find.byKey(const Key('talacare_logo'));
      expect(findLogo, findsOneWidget, reason: 'TalaCare logo should be visible');
    });

    testWidgets('Verify the pink layer is showing', (tester) async {
      await tester.pumpWidget(splashPage);
      await tester.pump(const Duration(seconds: delayDurationSeconds));

      final findPinkLayer = find.byKey(const Key('pink_layer'));
      expect(findPinkLayer, findsOneWidget, reason: 'Pink layer should be visible');
    });
  });
}
