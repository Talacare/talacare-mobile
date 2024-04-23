import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/datasources/game_history_remote_datasource.dart';
import 'package:talacare/data/models/game_history_model.dart';
import 'game_history_remote_datasource_test.mocks.dart';

@GenerateMocks([Dio, AuthLocalDatasource])
void main() {
  late MockDio mockDio;
  late MockAuthLocalDatasource mockAuthLocalDatasource;
  late GameHistoryRemoteDatasourceImpl dataSource;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    mockDio = MockDio();
    mockAuthLocalDatasource = MockAuthLocalDatasource();
    dataSource = GameHistoryRemoteDatasourceImpl(
      dio: mockDio,
      localDatasource: mockAuthLocalDatasource,
    );
    when(mockAuthLocalDatasource.readData('access_token'))
        .thenAnswer(((_) async => 'fake_token'));
  });

  test('should post data to API to create game history on success', () async {
    final gameHistoryModel = GameHistoryModel(
      gameType: 'PUZZLE',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      score: 100,
    );

    when(mockDio.post(any,
            data: anyNamed('data'), options: anyNamed('options')))
        .thenAnswer(((_) async => Response(
              requestOptions: RequestOptions(
                  path: '${dotenv.env['API_URL']!}/game-history'),
              statusCode: 200,
              data: {'responseStatus': "SUCCESS"},
            )));

    await dataSource.createGameHistory(gameHistoryModel);

    verify(mockDio.post(any,
            data: gameHistoryModel.toJson(), options: anyNamed('options')))
        .called(1);
  });

  test('should throw an error message when DioException is caught', () async {
    final gameHistoryModel = GameHistoryModel(
      gameType: 'PUZZLE',
      startTime: DateTime.now(),
      endTime: DateTime.now(),
      score: 100,
    );

    const errorMessage = "Failed to create game history";

    when(mockDio.post(any,
            data: anyNamed('data'), options: anyNamed('options')))
        .thenThrow(DioException(
      requestOptions:
          RequestOptions(path: '${dotenv.env['API_URL']!}/game-history'),
      response: Response(
        requestOptions:
            RequestOptions(path: '${dotenv.env['API_URL']!}/game-history'),
        statusCode: 400,
        data: {'responseMessage': errorMessage},
      ),
    ));

    expect(
      () async => await dataSource.createGameHistory(gameHistoryModel),
      throwsA(predicate((e) => e == errorMessage)),
    );
  });
}
