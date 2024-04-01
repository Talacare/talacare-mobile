import 'package:dio/dio.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/data/models/user_model.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'auth_remote_datasource_test.mocks.dart';

class MockGoogleSignInReturnsNull extends Mock implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() {
    return Future.value(null);
  }
}

class MockGoogleSignInThrowsException extends Mock implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() {
    throw Exception();
  }
}

class MockDio extends Mock implements Dio {
  @override
  Future<Response<T>> get<T>(String path,
      {Object? data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) {
    final data = {
      "responseMessage": "Login Successful",
      "responseCode": 200,
      "responseStatus": "SUCCESS",
      "token": "token"
    };

    final response = Response(requestOptions: RequestOptions(), statusCode: 200, data: data);
    return Future.value(response as Response<T>);
  }
}

@GenerateNiceMocks([
  MockSpec<AuthLocalDatasource>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<Response>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockDio mockDio;
  late MockAuthLocalDatasource mockLocalDatasource;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    mockFirebaseAuth = MockFirebaseAuth();
    mockDio = MockDio();
    mockLocalDatasource = MockAuthLocalDatasource();
  });

  test('should return UserModel on successful sign-in', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleSignIn(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );
    final result = await dataSource.signInGoogle();
    expect(result, isA<UserModel>());
  });

  test('should throw exception when the account is null', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleSignInReturnsNull(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });

  test('should throw unexpected exception', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleSignInThrowsException(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });
}
