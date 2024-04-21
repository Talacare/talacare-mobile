import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/schedule_remote_datasource.dart';
import 'package:talacare/data/models/schedule_model.dart';
import 'package:talacare/data/repositories/schedule_repository_impl.dart';

import 'schedule_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ScheduleRemoteDatasource>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  late ScheduleRepositoryImpl repository;
  late MockScheduleRemoteDatasource mockRemoteDatasource;

  const scheduleModel = ScheduleModel(
    id: 'schedule-id-123',
    hour: 10,
    minute: 30,
    userId: 'user-id-456',
  );

  setUp(() {
    mockRemoteDatasource = MockScheduleRemoteDatasource();
    repository = ScheduleRepositoryImpl(mockRemoteDatasource);
  });

  test('should call create schedule of schedule remote datasource', () async {
    when(mockRemoteDatasource.createSchedule(scheduleModel))
        .thenAnswer((_) async => Future.value());
    await repository.createSchedule(scheduleModel);
    verify(mockRemoteDatasource.createSchedule(scheduleModel)).called(1);
  });

  test(
      'should call getSchedulesByUserId from ScheduleRemoteDatasource and return expected data',
      () async {
    final scheduleModels = [
      const ScheduleModel(
        id: 'schedule-id-123',
        hour: 10,
        minute: 30,
        userId: 'user-id-456',
      ),
      const ScheduleModel(
        id: 'schedule-id-124',
        hour: 11,
        minute: 0,
        userId: 'user-id-456',
      ),
    ];

    when(mockRemoteDatasource.getSchedulesByUserId())
        .thenAnswer((_) async => scheduleModels);

    final result = await repository.getSchedulesByUserId();

    verify(mockRemoteDatasource.getSchedulesByUserId()).called(1);

    expect(result, equals(scheduleModels));
  });
}
