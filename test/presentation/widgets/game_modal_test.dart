import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/game_modal.dart';

void main() {
  group('Game Modal Widget Tests', () {
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
          body: GameModal(
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

          expect(find.text('$currentScore'), findsOneWidget,
              reason: 'Current score should be displayed correctly');

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

    testWidgets('Verify "Selesai" button triggers callback',
            (WidgetTester tester) async {
          await tester.pumpWidget(modal);

          final menuButton = find.text('Selesai');
          await tester.tap(menuButton);
          await tester.pump();

          expect(menuPressed, isTrue);
        });
  });
}
