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

  test('should return formatted schedules from getSchedulesByUserId', () async {
    final mockSchedules = [
      const ScheduleEntity(id: '1', hour: 9, minute: 5, userId: 'user1'),
      const ScheduleEntity(id: '2', hour: 14, minute: 20, userId: 'user2'),
      const ScheduleEntity(id: '3', hour: 23, minute: 59, userId: 'user3'),
    ];

    when(mockScheduleRepository.getSchedulesByUserId())
        .thenAnswer((_) async => mockSchedules);

    final formattedSchedules = await useCase.getSchedulesByUserId();

    final expectedFormattedSchedules = ['09:05', '14:20', '23:59'];
    expect(formattedSchedules, expectedFormattedSchedules);

    verify(mockScheduleRepository.getSchedulesByUserId()).called(1);
  });
}
