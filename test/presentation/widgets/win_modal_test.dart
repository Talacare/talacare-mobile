import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';

void main() {
  group('Win Puzzle Modal Widget Tests', () {
    testWidgets('Verify All Components are showing', (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider<TimerState>(
          create: (context) => TimerState(initialValue: true),
          child: const MaterialApp(
            home: Scaffold(
              body: NextInfo(),
            ),
          )));

      expect(find.text('SUSTER'), findsOneWidget);
      expect(find.text('Lanjut'), findsOneWidget);
    });

    testWidgets('Button is clickable', (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider<TimerState>(
          create: (context) => TimerState(initialValue: true),
          child: const MaterialApp(
            home: Scaffold(
              body: NextInfo(),
            ),
          )));
      await tester.tap(find.byKey(const Key('nextButton')));
      await tester.pump();
    });
  });

  testWidgets('Verify All Components are not showing when timerState is false', (tester) async {
    await tester.pumpWidget(ChangeNotifierProvider<TimerState>(
        create: (context) => TimerState(initialValue: false),
        child: const MaterialApp(
          home: Scaffold(
            body: NextInfo(),
          ),
        )));

    expect(find.text('SUSTER'), findsNothing);
    expect(find.text('Lanjut'), findsNothing);
  });
}
