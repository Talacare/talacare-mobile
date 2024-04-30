import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngineUtil {
  static final _instance = FirebaseAnalytics.instance;

  static void userPlaysPuzzle() async {
    await _instance.logEvent(name: 'plays_puzzle');
  }

  static void userPlaysPuzzleAgain() async {
    await _instance.logEvent(name: 'plays_puzzle_again');
  }

  static void userStopPlaysPuzzle() async {
    await _instance.logEvent(name: 'plays_stop_puzzle');
  }

  static void userPlaysJumpNJump() async {
    await _instance.logEvent(name: 'plays_jumpnjump');
  }
}
