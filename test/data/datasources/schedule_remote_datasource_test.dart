import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/datasources/schedule_remote_datasource.dart';
import 'package:talacare/data/models/schedule_model.dart';

import 'schedule_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio, AuthLocalDatasource])
void main() {
  late MockDio mockDio;
  late MockAuthLocalDatasource mockAuthLocalDatasource;
  late ScheduleRemoteDatasourceImpl dataSource;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    mockDio = MockDio();
    mockAuthLocalDatasource = MockAuthLocalDatasource();
    dataSource = ScheduleRemoteDatasourceImpl(
        dio: mockDio, localDatasource: mockAuthLocalDatasource);

    when(mockAuthLocalDatasource.readData('access_token'))
        .thenAnswer((_) async => 'fake_token');
  });

  test('should post data to API to create schedule on success', () async {
    const scheduleModel = ScheduleModel(hour: 10, minute: 30);

    when(mockDio.post(any,
            data: anyNamed('data'), options: anyNamed('options')))
        .thenAnswer((_) async => Response(
            requestOptions:
                RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
            statusCode: 200,
            data: {'responseStatus': "SUCCESS"}));

    await dataSource.createSchedule(scheduleModel);

    verify(mockDio.post(any,
            data: {'hour': scheduleModel.hour, 'minute': scheduleModel.minute},
            options: anyNamed('options')))
        .called(1);
  });

  test('should throw an error message when DioException is caught', () async {
    const scheduleModel = ScheduleModel(hour: 10, minute: 30);
    const errorMessage = "Jadwal yang sama sudah tersedia";

    when(mockDio.post(any,
            data: anyNamed('data'), options: anyNamed('options')))
        .thenThrow(DioException(
            requestOptions:
                RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
            response: Response(
                requestOptions:
                    RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
                statusCode: 400,
                data: {'responseMessage': errorMessage})));

    expect(
      () async => await dataSource.createSchedule(scheduleModel),
      throwsA(predicate((e) => e == errorMessage)),
    );
  });

  test('should retrieve list of schedules on success', () async {
    const fakeScheduleData = [
      {'hour': 10, 'minute': 30},
      {'hour': 14, 'minute': 45},
    ];

    when(mockDio.get(any, options: anyNamed('options'))).thenAnswer((_) async =>
        Response(
            requestOptions:
                RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
            statusCode: 200,
            data: {'data': fakeScheduleData}));

    final result = await dataSource.getSchedulesByUserId();

    expect(result, hasLength(2));
    expect(result[0].hour, 10);
    expect(result[1].minute, 45);

    verify(mockDio.get(any, options: anyNamed('options'))).called(1);
  });

  test(
      'should throw an error message when DioException is caught on getSchedulesByUserId',
      () async {
    const errorMessage = "Failed to retrieve schedules";

    when(mockDio.get(any, options: anyNamed('options'))).thenThrow(DioException(
        requestOptions:
            RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
        response: Response(
            requestOptions:
                RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
            statusCode: 400,
            data: {'responseMessage': errorMessage})));

    expect(
      () async => await dataSource.getSchedulesByUserId(),
      throwsA(predicate((e) => e == errorMessage)),
    );
  });

  test('Should delete schedule successfully', () async {
    const scheduleId = '123';

    when(mockDio.delete(any,
            data: anyNamed('data'), options: anyNamed('options')))
        .thenAnswer((_) async => Response(
            requestOptions: RequestOptions(
                path: '${dotenv.env['API_URL']!}/schedule/$scheduleId'),
            statusCode: 200,
            data: {'responseStatus': "SUCCESS"}));

    await dataSource.deleteSchedule(scheduleId);

    verify(mockDio.delete(
      '${dotenv.env['API_URL']!}/schedule/$scheduleId',
      options: anyNamed('options'),
    )).called(1);
  });

  test('Should throw error if DioException occurs', () async {
    const scheduleId = '123';
    final dioErrorResponse = Response(
      requestOptions: RequestOptions(path: ''),
      data: {'responseMessage': 'Not Authorized'},
    );
    final dioException = DioException(
      requestOptions: RequestOptions(path: ''),
      response: dioErrorResponse,
    );
    when(mockDio.delete(
      '${dotenv.env['API_URL']!}/schedule/$scheduleId',
      options: anyNamed('options'),
    )).thenThrow(dioException);

    expect(
      () async => await dataSource.deleteSchedule(scheduleId),
      throwsA('Not Authorized'),
    );
  });
}
