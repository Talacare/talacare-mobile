import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/pages/jump_n_jump_page.dart';

void main() {
  group('JumpNJumpPage Widget Tests', () {
    testWidgets('Coin icon and score display are correctly shown',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: JumpNJumpPage()));

      expect(find.byKey(const Key('coinIcon')), findsOneWidget);

      expect(find.byKey(const Key('scoreDisplay')), findsOneWidget);
    });

    testWidgets('High score display is correctly shown',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: JumpNJumpPage()));

      expect(find.byKey(const Key('highScoreDisplay')), findsOneWidget);
    });

    testWidgets('Control buttons are correctly shown',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: JumpNJumpPage()));

      expect(find.byKey(const Key('leftControlButton')), findsOneWidget);

      expect(find.byKey(const Key('rightControlButton')), findsOneWidget);
    });

    testWidgets('Simulating control button presses does not throw errors',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: JumpNJumpPage()));

      final Finder leftButton = find.byKey(const Key('leftControlButton'));
      final TestGesture leftGesture =
          await tester.startGesture(tester.getCenter(leftButton));
      await tester.pump();
      await leftGesture.up();
      await tester.pump();

      final Finder rightButton = find.byKey(const Key('rightControlButton'));
      final TestGesture rightGesture =
          await tester.startGesture(tester.getCenter(rightButton));
      await tester.pump();
      await rightGesture.up();
      await tester.pump();
    });
  });
}
