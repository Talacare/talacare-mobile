import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/repositories/schedule_repository.dart';

class ScheduleUseCase {
  final ScheduleRepository scheduleRepository;

  ScheduleUseCase(this.scheduleRepository);

  Future<void> createSchedule(ScheduleEntity schedule) async {
    await scheduleRepository.createSchedule(schedule);
  }
}
