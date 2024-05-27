import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeTracker with WidgetsBindingObserver {
  Timer? _timer;
  int accumulatedTime = 0;
  static const int dailyLimit = 3600 * 2; // unit = second
  bool isAlreadyTwoHours = false;

  void start() {
    WidgetsBinding.instance.addObserver(this);
    resetTimer();
    startTimer();
    resetDailyTimeIfNeeded();
  }

  void stop() {
    WidgetsBinding.instance.removeObserver(this);
    stopTimer();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      resetDailyTimeIfNeeded();
      loadAccumulatedTime();
      startTimer();
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      stopTimer();
      saveAccumulatedTime();
    }
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (accumulatedTime < dailyLimit) {
        accumulatedTime++;
      } else {
        isAlreadyTwoHours = true;
        stopTimer();
      }
    });
  }

  void resetTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accumulatedTime', 0);
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resetDailyTimeIfNeeded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastDate = prefs.getString('lastDate');
    String todayDate = DateTime.now().toIso8601String().split('T').first;

    if (lastDate == null || lastDate != todayDate) {
      await prefs.setString('lastDate', todayDate);
      accumulatedTime = 0;
      isAlreadyTwoHours = false;
      saveAccumulatedTime();
    }
  }

  void loadAccumulatedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accumulatedTime = prefs.getInt('accumulatedTime') ?? 0;
  }

  void saveAccumulatedTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('accumulatedTime', accumulatedTime);
  }
}
