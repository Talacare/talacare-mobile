import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/repositories/schedule_repository.dart';
import 'package:talacare/domain/usecases/schedule_usecase.dart';

import 'schedule_usecase_test.mocks.dart';

@GenerateMocks([ScheduleRepository])
void main() {
  late ScheduleUseCase useCase;
  late MockScheduleRepository mockScheduleRepository;
  const scheduleEntity = ScheduleEntity(
      id: 'schedule-id-123', hour: 10, minute: 30, userId: 'user-id-456');

  setUp(() {
    mockScheduleRepository = MockScheduleRepository();
    useCase = ScheduleUseCase(mockScheduleRepository);
  });

  test('should invoke createSchedule on the schedule repository', () async {
    when(mockScheduleRepository.createSchedule(any))
        .thenAnswer((_) async => {});
    await useCase.createSchedule(scheduleEntity);
    verify(mockScheduleRepository.createSchedule(scheduleEntity)).called(1);
  });
}
