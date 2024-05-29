import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:talacare/core/utils/time_tracker.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

class MockTimeTracker extends Mock implements TimeTracker {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late TimeTracker timeTracker;
  late MockTimeTracker mockTimeTracker;

  setUp(() {
    timeTracker = TimeTracker();
    mockTimeTracker = MockTimeTracker();

    SharedPreferences.setMockInitialValues({});
  });

  test('Timer increments accumulated time', () async {
    timeTracker.start();

    await Future.delayed(const Duration(seconds: 1));

    expect(timeTracker.accumulatedTime, 1);
    timeTracker.stop();
  });

  test('Timer stops at daily limit', () {
    fakeAsync((async) {
      timeTracker.start();
      async.elapse(const Duration(seconds: TimeTracker.dailyLimit + 1));

      expect(timeTracker.accumulatedTime, TimeTracker.dailyLimit);
      timeTracker.stop();
    });
  });

  test('didChangeAppLifecycleState calls the correct methods on resumed', () {
    when(mockTimeTracker.resetDailyTimeIfNeeded()).thenReturn(null);
    when(mockTimeTracker.loadAccumulatedTime()).thenReturn(null);
    when(mockTimeTracker.startTimer()).thenReturn(null);

    timeTracker.didChangeAppLifecycleState(AppLifecycleState.resumed);

    expect(
      () => timeTracker.resetDailyTimeIfNeeded(),
      isA<void>(),
    );
  });

  test('didChangeAppLifecycleState calls the correct methods on paused', () {
    when(mockTimeTracker.stopTimer()).thenReturn(null);
    when(mockTimeTracker.saveAccumulatedTime()).thenReturn(null);

    timeTracker.didChangeAppLifecycleState(AppLifecycleState.paused);

    expect(
      () => timeTracker.stopTimer(),
      isA<void>(),
    );
  });
}
