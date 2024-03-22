import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngineUtil {
  static final _instance = FirebaseAnalytics.instance;

  static void userPlaysPuzzle() async {
    await _instance.logEvent(name: 'plays_puzzle');
  }
}
