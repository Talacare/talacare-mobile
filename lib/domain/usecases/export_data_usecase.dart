import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/repositories/export_data_repository.dart';

class ExportDataUseCase {
  final ExportDataRepository exportDataRepository;

  ExportDataUseCase(this.exportDataRepository);

  Future<void> createSchedule(ScheduleEntity schedule) async {
    await exportDataRepository.exportGameData();
  }
}
