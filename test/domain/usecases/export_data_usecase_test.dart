import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/repositories/export_data_repository.dart';
import 'package:talacare/domain/usecases/export_data_usecase.dart';

import 'export_data_usecase_test.mocks.dart';

@GenerateMocks([ExportDataRepository])
void main() {
  late ExportDataUseCase useCase;
  late MockExportDataRepository mockExportDataRepository;
  const scheduleEntity = ScheduleEntity(
      id: 'schedule-id-123', hour: 10, minute: 30, userId: 'user-id-456');

  setUp(() {
    mockExportDataRepository = MockExportDataRepository();
    useCase = ExportDataUseCase(mockExportDataRepository);
  });

  test('should invoke createSchedule on the schedule repository', () async {
    when(mockExportDataRepository.exportGameData()).thenAnswer((_) async => {});
    await useCase.createSchedule(scheduleEntity);
    verify(mockExportDataRepository.exportGameData()).called(1);
  });
}
