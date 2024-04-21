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
}
