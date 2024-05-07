import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/datasources/export_data_remote_datasource.dart';

import 'schedule_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio, AuthLocalDatasource])
void main() {
  late MockDio mockDio;
  late MockAuthLocalDatasource mockAuthLocalDatasource;
  late ExportDataRemoteDatasourceImpl dataSource;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    mockDio = MockDio();
    mockAuthLocalDatasource = MockAuthLocalDatasource();
    dataSource = ExportDataRemoteDatasourceImpl(
        dio: mockDio, localDatasource: mockAuthLocalDatasource);

    when(mockAuthLocalDatasource.readData('access_token'))
        .thenAnswer((_) async => 'fake_token');
  });

  test('should get data to API to create schedule on success', () async {
    when(mockDio.get(any, options: anyNamed('options'))).thenAnswer((_) async =>
        Response(
            requestOptions:
                RequestOptions(path: '${dotenv.env['API_URL']!}/export-data'),
            statusCode: 200,
            data: {'responseStatus': "SUCCESS"}));

    await dataSource.exportData();

    verify(mockDio.get(any, options: anyNamed('options'))).called(1);
  });

  test(
      'should throw an error message export data failed when DioException is caught',
      () async {
    const errorMessage = "Export data failed";

    when(mockDio.get(any, options: anyNamed('options'))).thenThrow(DioException(
        requestOptions:
            RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
        response: Response(
            requestOptions:
                RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
            statusCode: 400,
            data: {'responseMessage': errorMessage})));

    expect(
      () async => await dataSource.exportData(),
      throwsA(predicate((e) => e == errorMessage)),
    );
  });

  test(
      'should throw an error message forbidden user when DioException is caught',
      () async {
    const errorMessage = "Only user with role admin can export the game data";

    when(mockDio.get(any, options: anyNamed('options'))).thenThrow(DioException(
        requestOptions:
            RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
        response: Response(
            requestOptions:
                RequestOptions(path: '${dotenv.env['API_URL']!}/schedule'),
            statusCode: 400,
            data: {'responseMessage': errorMessage})));

    expect(
      () async => await dataSource.exportData(),
      throwsA(predicate((e) => e == errorMessage)),
    );
  });
}
