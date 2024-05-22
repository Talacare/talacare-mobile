import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/presentation/puzzle/info/circle_timer.dart';
import 'package:talacare/core/constants/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:talacare/presentation/puzzle/state/complete_state.dart';
import 'package:talacare/presentation/puzzle/state/timer_state.dart';
import 'package:talacare/presentation/puzzle/state/time_left_state.dart';

class MockTimerState extends Mock implements TimerState {}

void main() {
  late Widget circleTimer;
  late Widget circleCompleted;

  setUp(() async {
    circleTimer = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: false),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: const MaterialApp(
          home: CircleTimer(
            currentScore: 12,
            highestScore: 30,
          ),
        ));

    circleCompleted = MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (context) => TimerState(initialValue: false),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: true),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: const MaterialApp(
          home: CircleTimer(
            currentScore: 12,
            highestScore: 30,
          ),
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

  testWidgets('CircleTimer sets isComplete to true after 60 seconds',
      (WidgetTester tester) async {
    final isComplete = CompleteState(initialValue: false);

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (_) => TimerState(initialValue: false),
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => isComplete,
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: const MaterialApp(
          home: CircleTimer(
            currentScore: 12,
            highestScore: 30,
          ),
        )));

    expect(isComplete.value, false);

    await tester.pump(const Duration(seconds: 60));

    expect(isComplete.value, true);
  });

  testWidgets('CircleTimer pause time when timePause to true',
      (WidgetTester tester) async {
    final timePause = TimerState(initialValue: true);

    await tester.pumpWidget(MultiProvider(
        providers: [
          ChangeNotifierProvider<TimerState>(
            create: (_) => timePause,
          ),
          ChangeNotifierProvider<CompleteState>(
            create: (context) => CompleteState(initialValue: false),
          ),
          ChangeNotifierProvider<TimeLeftState>(
            create: (context) => TimeLeftState(initialValue: 60),
          ),
        ],
        child: const MaterialApp(
          home: CircleTimer(
            currentScore: 12,
            highestScore: 30,
          ),
        )));

    expect(timePause.value, true);

    await tester.pump(const Duration(seconds: 60));

    expect(find.text('60'), findsOneWidget);
  });
}
