import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late Widget nextInfo;

  setUp(() async {
    nextInfo = ChangeNotifierProvider<TimerState>(
        create: (context) => TimerState(initialValue: true),
        child: const MaterialApp(
          home: Scaffold(
            body: NextInfo(),
          ),
        )
    );
  });
  
  group('Win Puzzle Modal Widget Tests', () {
    testWidgets('Verify All Components are showing', (tester) async {
      await tester.pumpWidget(nextInfo);

      expect(find.text('SUSTER'), findsOneWidget);
      expect(find.text('Lanjut'), findsOneWidget);
      expect(find.byKey(const Key('nextButton')), findsOneWidget);
    });

    testWidgets('Button is clickable to Previous Page', (tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<TimerState>(
          create: (context) => TimerState(initialValue: true),
          child: const MaterialApp(
            home: Scaffold(
              body: NextInfo(),
            ),
          )
          ),
          navigatorObservers: [mockObserver],
        ),
      );

      expect(find.byKey(const Key('nextButton')), findsOneWidget);
      await tester.tap(find.byKey(const Key('nextButton')));
      await tester.pumpAndSettle();
    });
  });

  testWidgets('Verify All Components are not showing when timerState is false',
      (tester) async {
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
