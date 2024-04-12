import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/usecases/schedule_usecase.dart';
import 'package:talacare/presentation/providers/schedule_provider.dart';

import 'schedule_provider_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<ScheduleUseCase>(onMissingStub: OnMissingStub.returnDefault)])
void main() {
  late ScheduleProvider scheduleProvider;
  late MockScheduleUseCase mockScheduleUseCase;
  const scheduleEntity = ScheduleEntity(
      id: 'schedule-id-123', hour: 10, minute: 30, userId: 'user-id-456');

  setUp(() {
    mockScheduleUseCase = MockScheduleUseCase();
    scheduleProvider = ScheduleProvider(useCase: mockScheduleUseCase);
  });

  test('should correctly handle a successful schedule creation', () async {
    when(mockScheduleUseCase.createSchedule(any))
        .thenAnswer((_) async => Future.value());

    await scheduleProvider.createSchedule(scheduleEntity);

    expect(scheduleProvider.isLoading, false);
    expect(scheduleProvider.isError, false);
    expect(scheduleProvider.message, 'Jadwal berhasil dibuat');
    verify(mockScheduleUseCase.createSchedule(scheduleEntity)).called(1);
  });

  test('should correctly handle a failed schedule creation', () async {
    const errorMessage = 'Jadwal gagal dibuat';
    when(mockScheduleUseCase.createSchedule(any))
        .thenThrow(Exception(errorMessage));

    await scheduleProvider.createSchedule(scheduleEntity);

    expect(scheduleProvider.isLoading, false);
    expect(scheduleProvider.isError, true);
    expect(scheduleProvider.message, contains(errorMessage));
    verify(mockScheduleUseCase.createSchedule(scheduleEntity)).called(1);
  });
}
