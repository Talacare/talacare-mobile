import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Modal Widget Tests', () {
    late Widget modal;
    bool mainLagiPressed = false;
    bool menuPressed = false;
    int currentScore = 999;
    int highestScore = 9999;

    setUp(() {
      mainLagiPressed = false;
      menuPressed = false;

      modal = MaterialApp(
        home: Scaffold(
          body: Modal(
            currentScore: currentScore,
            highestScore: highestScore,
            onMainLagiPressed: () => mainLagiPressed = true,
            onMenuPressed: () => menuPressed = true,
          ),
        ),
      );
    });

    testWidgets('Verify current score and high score are displayed correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(modal);

      // Verify current score is displayed
      expect(find.text('$currentScore'), findsOneWidget,
          reason: 'Current score should be displayed correctly');

      // Verify high score is displayed
      expect(find.text('$highestScore'), findsOneWidget,
          reason: 'High score should be displayed correctly');
    });

    testWidgets('Verify "Main Lagi" button triggers callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(modal);

      final mainLagiButton = find.text('Main Lagi');
      await tester.tap(mainLagiButton);
      await tester.pump();

      expect(mainLagiPressed, isTrue);
    });

    testWidgets('Verify "Menu" button triggers callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(modal);

      final menuButton = find.text('Menu');
      await tester.tap(menuButton);
      await tester.pump();

      expect(menuPressed, isTrue);
    });
  });
}
