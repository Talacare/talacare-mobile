import 'package:talacare/domain/entities/schedule_entity.dart';

abstract class ScheduleRepository {
  Future<void> createSchedule(ScheduleEntity schedule);
  Future<List<ScheduleEntity>> getSchedulesByUserId();
  Future<void> deleteSchedule(String scheduleId);
}
