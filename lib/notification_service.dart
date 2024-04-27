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
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max)
    );
  }

  Future<void> showNotification(
      {int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  DateTime _nextInstanceOfTime({required DateTime dateTime}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return DateTime(
      scheduledDate.year, scheduledDate.month, scheduledDate.day, scheduledDate.hour, scheduledDate.minute
    );
  }

  Future<void> scheduleNotificationHelper(
    {
      required int id,
      String? payload,
      required String scheduledTime
    }
  ) async {

    DateTime scheduleDate = DateTime(
                  2020,
                  04,
                  05,
                  int.parse(scheduledTime.substring(0,2)),
                  int.parse(scheduledTime.substring(3))
                );

    await scheduleNotification(
      id: id,
      title: "Pengingat Obat",
      body: "Jangan Lupa Minum Obat Kelasi Besi",
      payload: payload,
      scheduledNotificationDateTime: scheduleDate
    );
  }

  Future<void> scheduleNotification(
    {required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledNotificationDateTime}
  ) async {
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      payload: payload,
      tz.TZDateTime.from(
        _nextInstanceOfTime(dateTime: scheduledNotificationDateTime),
        tz.local,
      ),
      const NotificationDetails(
        android: AndroidNotificationDetails('daily notification channel id',
          'daily notification channel name',
          channelDescription: 'daily notification description'),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> cancelNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  Future<void> cancelAllNotification() async {
    await notificationsPlugin.cancelAll();
  }

  Future<void> checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await notificationsPlugin.pendingNotificationRequests();

    print('${pendingNotificationRequests.length} pending notification ');

    for (PendingNotificationRequest pendingNotificationRequest in pendingNotificationRequests) {
      print(pendingNotificationRequest.id.toString() +
          " " +
          (pendingNotificationRequest.payload ?? ""));
    }
    print('NOW ' + tz.TZDateTime.now(tz.local).toString());
  }
}