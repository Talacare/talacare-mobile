import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/data/repositories/schedule_notification_adapter.dart';

void main() {
  late ScheduleNotificationAdapter scheduleNotification;

  setUp(() {
    scheduleNotification = ScheduleNotificationAdapter();
  });

  group('Test Schedule Notifier Adapter', () {
   test('Check if time format is true', () {
      String time = "20:20";
      DateTime target = DateTime(
                        2020,
                        04,
                        05,
                        int.parse(time.substring(0,2)),
                        int.parse(time.substring(3))
                      );
      
      DateTime check = scheduleNotification.changeTimeFormat(time);

      //Assert
      expect(target == check, true);
    });

  });
}