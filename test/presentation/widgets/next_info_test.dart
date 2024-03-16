import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/data/models/stage_state.dart';
import 'package:talacare/presentation/puzzle/complete_state.dart';
import 'package:talacare/presentation/widgets/next_info.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/timer_state.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late Widget nextInfo;

  setUp(() async {
    nextInfo = MultiProvider (
      providers :[
        ChangeNotifierProvider<TimerState>(
          create: (context) => TimerState(initialValue: true)
        ),
        ChangeNotifierProvider<CompleteState>(
          create: (context) => CompleteState(initialValue: false),
        )
      ],
      child: MaterialApp(
        home: Scaffold(
          body: NextInfo(stageState: StageState([1,0,0,0], 1)),
        ),
      ));
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
          home: MultiProvider (
          providers :[
            ChangeNotifierProvider<TimerState>(
              create: (context) => TimerState(initialValue: true)
            ),
            ChangeNotifierProvider<CompleteState>(
              create: (context) => CompleteState(initialValue: false),
            )
          ],
          child: MaterialApp(
            home: Scaffold(
              body: NextInfo(stageState: StageState([1,0,0,0], 1)),
            ),
          )),
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
    await tester.pumpWidget(
      MultiProvider (
        providers :[
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: false)
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          )
        ],
        child: MaterialApp(
          home: Scaffold(
            body: NextInfo(stageState: StageState([1,0,0,0], 1)),
          ),
        ))
      );

    expect(find.text('SUSTER'), findsNothing);
    expect(find.text('Lanjut'), findsNothing);
  });
}
