import 'package:talacare/domain/repositories/notification_adapter.dart';
import 'package:talacare/notification_service.dart';

class ScheduleNotificationAdapter extends NotificationAdapter {
  DateTime changeTimeFormat(String scheduledTime) {
    return DateTime(
                  2020,
                  04,
                  05,
                  int.parse(scheduledTime.substring(0,2)),
                  int.parse(scheduledTime.substring(3))
                );
  }

  @override
  void createNotification(List<Map<String, String>> schedules) {
    NotificationService().cancelAllNotification();

    for (var i = 0; i < schedules.length; i++) {
      Map<String, String> schedule = schedules[i];

      NotificationService().scheduleNotification(
        id: i,
        title: "Pengingat Obat",
        body: "Jangan Lupa Minum Obat Kelasi Besi",
        payload: schedule["id"]!,
        scheduledNotificationDateTime: changeTimeFormat(schedule["time"]!)
      );
    }
  }

  @override
  void deleteNotification(String payload) {
    NotificationService().cancelNotificationPayload(payload);
  }
}