import 'package:talacare/data/datasources/schedule_remote_datasource.dart';
import 'package:talacare/data/models/schedule_model.dart';
import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final ScheduleRemoteDatasource scheduleRemoteDatasource;

  ScheduleRepositoryImpl(this.scheduleRemoteDatasource);

  @override
  Future<void> createSchedule(ScheduleEntity schedule) async {
    if (schedule is ScheduleModel) {
      await scheduleRemoteDatasource.createSchedule(schedule);
    }
  }

  @override
  Future<List<ScheduleEntity>> getSchedulesByUserId() async {
    final schedules = await scheduleRemoteDatasource.getSchedulesByUserId();
    return schedules;
  }
}
