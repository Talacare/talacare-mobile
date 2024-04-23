import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/repositories/schedule_repository.dart';

class ScheduleUseCase {
  final ScheduleRepository scheduleRepository;

  ScheduleUseCase(this.scheduleRepository);

  Future<void> createSchedule(ScheduleEntity schedule) async {
    await scheduleRepository.createSchedule(schedule);
  }

  Future<List<Map<String, String>>> getSchedulesByUserId() async {
    final schedules = await scheduleRepository.getSchedulesByUserId();
    final formattedSchedules = schedules.map((schedule) {
      final hour = schedule.hour.toString().padLeft(2, '0');
      final minute = schedule.minute.toString().padLeft(2, '0');
      final formattedTime = '$hour:$minute';

      return {
        'id': schedule.id!,
        'time': formattedTime,
      };
    }).toList();

    return formattedSchedules;
  }
}
