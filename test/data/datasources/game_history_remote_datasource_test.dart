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

  test(
      'should throw an error message when DioException is caught on createGameHistory',
      () async {
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

  test(
      'should get highest score game history data when successfully call the get highest score game history',
      () async {
    final expectedHighestScoreGameHistoryModel = GameHistoryModel(
      gameType: 'PUZZLE',
      startTime: DateTime.parse('2024-04-04 10:30:00.000'),
      endTime: DateTime.parse('2024-04-04 12:00:00.000'),
      score: 100,
    );
    final gameType = 'PUZZLE';

    final fakeHighestScoreGameHistoryData = {
      'gameType': 'PUZZLE',
      'startTime': '2024-04-04 10:30:00.000',
      'endTime': '2024-04-04 12:00:00.000',
      'score': 100
    };

    when(mockDio.get(any, options: anyNamed('options')))
        .thenAnswer(((_) async => Response(
              requestOptions: RequestOptions(
                  path:
                      '${dotenv.env['API_URL']!}/game-history/high-score/${gameType}'),
              statusCode: 200,
              data: {
                'responseStatus': "SUCCESS",
                'data': fakeHighestScoreGameHistoryData
              },
            )));

    final highestScoreGameHistoryModel =
        await dataSource.getHighestScoreHistory(gameType);

    expect(highestScoreGameHistoryModel,
        equals(expectedHighestScoreGameHistoryModel));
    verify(mockDio.get(any, options: anyNamed('options'))).called(1);
  });

  test(
      'should throw an error message when DioException is caught on getHighestScoreHistory',
      () async {
    final gameType = 'PUZZLE';

    const errorMessage = "Failed to retrieve highest score game history";

    when(mockDio.get(any, options: anyNamed('options'))).thenThrow(DioException(
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
      () async => await dataSource.getHighestScoreHistory(gameType),
      throwsA(predicate((e) => e == errorMessage)),
    );
  });
}
