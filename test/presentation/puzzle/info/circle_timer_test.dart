import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/puzzle/info/circle_timer.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';

class MockTimerState extends Mock implements TimerState {}

void main() {
  late Widget circleTimer;
  late Widget circleCompleted;

  setUp(() async {
    circleTimer = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: true),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
        ],
        child: const MaterialApp(
          home: CircleTimer(),
        ));

    circleCompleted = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: true),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: true),
          ),
        ],
        child: const MaterialApp(
          home: CircleTimer(),
        ));
  });

  testWidgets('CircleTimer widget has correct CircularProgressIndicator color',
      (WidgetTester tester) async {
    await tester.pumpWidget(circleTimer);

    CircularProgressIndicator circularProgressIndicator =
        tester.widget(find.byType(CircularProgressIndicator));

    expect(circularProgressIndicator.backgroundColor, AppColors.purple);
    expect(circularProgressIndicator.valueColor,
        isInstanceOf<AlwaysStoppedAnimation<Color>>());
  });

  testWidgets('CircleTimer widget always display 60 seconds at the beginning',
      (WidgetTester tester) async {
    await tester.pumpWidget(circleTimer);

    expect(find.text('60'), findsOneWidget);

    await tester.pumpWidget(circleTimer);
    expect(find.text('60'), findsOneWidget);
  });

  testWidgets('CircleTimer widget display remaining seconds after time passed',
      (WidgetTester tester) async {
    await tester.pumpWidget(circleTimer);

    await tester.pump(const Duration(seconds: 1));
    expect(find.text('59'), findsOneWidget);

    await tester.pump(const Duration(seconds: 59));
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets(
      'CircleTimer widget continues to display 0 seconds even after more than 60 seconds have passed',
      (WidgetTester tester) async {
    await tester.pumpWidget(circleTimer);

    await tester.pump(const Duration(seconds: 70));
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('CircleTimer widget not decrement time if puzzle is solved',
      (WidgetTester tester) async {
    await tester.pumpWidget(circleCompleted);

    await tester.pump();
    expect(find.text('60'), findsOneWidget);
  });

  testWidgets('CircleTimer sets timerState to true after 60 seconds',
      (WidgetTester tester) async {
    final timerState = TimerState(initialValue: false);

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (_) => timerState,
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
        ],
        child: const MaterialApp(
          home: CircleTimer(),
        )));

    expect(timerState.value, false);

    await tester.pump(const Duration(seconds: 60));

    expect(timerState.value, true);
  });
}
