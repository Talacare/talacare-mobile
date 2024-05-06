import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/domain/entities/schedule_entity.dart';

void main() {
  const schedule = ScheduleEntity(
    id: 'schedule-id-123',
    hour: 10,
    minute: 30,
    userId: 'user-id-456',
  );

  test('ScheduleEntity instances with the same properties should be equal', () {
    const otherSchedule = ScheduleEntity(
      id: 'schedule-id-123',
      hour: 10,
      minute: 30,
      userId: 'user-id-456',
    );

    expect(schedule, equals(otherSchedule));
  });

  test('ScheduleEntity instances with different properties should not be equal',
      () {
    const otherSchedule = ScheduleEntity(
      id: 'schedule-id-456',
      hour: 11,
      minute: 45,
      userId: 'user-id-789',
    );
    expect(schedule, isNot(equals(otherSchedule)));
  });

  test(
    'ScheduleEntity should generate correct list of props',
    () {
      expect(
        schedule.props,
        equals(
          ['schedule-id-123', 10, 30, 'user-id-456'],
        ),
      );
    },
  );
}
