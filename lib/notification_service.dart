import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
  }

  Future<void> initNotification() async {
    await _configureLocalTimeZone();

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max)
    );
  }

// Just ignore this comment will be removed in next commit
//   Future<void> checkPendingNotificationRequests() async {
//   final List<PendingNotificationRequest> pendingNotificationRequests =
//       await notificationsPlugin.pendingNotificationRequests();
  
//   print('${pendingNotificationRequests.length} pending notification ');

//   for (PendingNotificationRequest pendingNotificationRequest in pendingNotificationRequests) {
//     print(pendingNotificationRequest.id.toString() +
//         " " +
//         (pendingNotificationRequest.payload ?? ""));
//   }
//   print('NOW ' + tz.TZDateTime.now(tz.local).toString());
// }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    return notificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduledNotificationDateTime,
          tz.local,
        ),
        await notificationDetails(),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}