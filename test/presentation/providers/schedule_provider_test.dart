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

  test('should fetch schedules by user ID successfully', () async {
    const schedules = [
      {'id': '1', 'time': '09:05'},
      {'id': '2', 'time': '14:20'},
      {'id': '3', 'time': '23:59'},
    ];

    when(mockScheduleUseCase.getSchedulesByUserId())
        .thenAnswer((_) async => Future.value(schedules));

    await scheduleProvider.getSchedulesByUserId();

    expect(scheduleProvider.schedules, schedules);
    expect(scheduleProvider.isError, false);
    verify(mockScheduleUseCase.getSchedulesByUserId()).called(1);
  });

  test('should handle errors when fetching schedules by user ID', () async {
    const errorMessage = 'Failed to get schedules';
    when(mockScheduleUseCase.getSchedulesByUserId())
        .thenThrow(Exception(errorMessage));

    await scheduleProvider.getSchedulesByUserId();
    
    expect(scheduleProvider.message, contains(errorMessage));
    expect(scheduleProvider.schedules, isEmpty);
    verify(mockScheduleUseCase.getSchedulesByUserId()).called(1);
  });

  test('should correctly handle a successful schedule deletion', () async {
    const scheduleId = 'schedule-123';

    when(mockScheduleUseCase.deleteSchedule(scheduleId))
        .thenAnswer((_) async => Future.value());

    await scheduleProvider.deleteSchedule(scheduleId);

    expect(scheduleProvider.isLoading, false);
    expect(scheduleProvider.isError, false);
    expect(scheduleProvider.message, 'Jadwal berhasil dihapus');

    verify(mockScheduleUseCase.deleteSchedule(scheduleId)).called(1);
  });

  test('should correctly handle a failed schedule deletion', () async {
    const scheduleId = 'schedule-123';
    final error = Exception('Failed to delete schedule');

    when(mockScheduleUseCase.deleteSchedule(scheduleId)).thenThrow(error);

    await scheduleProvider.deleteSchedule(scheduleId);

    expect(scheduleProvider.isLoading, false);
    expect(scheduleProvider.isError, true);
    expect(scheduleProvider.message, error.toString());

    verify(mockScheduleUseCase.deleteSchedule(scheduleId)).called(1);
  });
}
