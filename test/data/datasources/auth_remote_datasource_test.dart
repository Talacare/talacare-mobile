import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class MockGoogleReturnsNull extends Mock implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() {
    return Future.value(null);
  }

  @override
  Future<GoogleSignInAccount?> signOut() {
    throw Exception();
  }
}

class MockGoogleThrowsException extends Mock implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() {
    throw Exception();
  }

  @override
  Future<GoogleSignInAccount?> signOut() {
    throw Exception();
  }
}

class MockGoogleSignInReturnsUserModel extends Mock
    implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() {
    throw Exception();
  }
}

class MockGoogleSignOut extends Mock implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signOut() {
    return Future.value();
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
      "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJmb29AZW1haWwuY29tIiwiZXhwIjoxNjM4ODU1MzA1LCJpYXQiOjE2Mzg4MTkzMDV9.q4FWV7yVDAs_DREiF524VZ-udnqwV81GEOgdCj6QQAs"
    };

    final response =
        Response(requestOptions: RequestOptions(), statusCode: 200, data: data);
    return Future.value(response as Response<T>);
  }
}

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return Future.value(MockUserCredential());
  }

  @override
  Future<void> signOut() async {
    return Future.value();
  }
}

class MockUserCredential extends Mock implements UserCredential {
  final _user = MockUser();

  @override
  User? get user => _user;
}

class MockUser extends Mock implements User {
  @override
  Future<String?> getIdToken([bool forceRefresh = false]) {
    return Future.value('token');
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
      googleSignIn: MockGoogleReturnsNull(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });

  test('should throw unexpected exception', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleThrowsException(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });

  test('should log out successfully', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleSignOut(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );

    await dataSource.logOut();

    verify(mockLocalDatasource.deleteData('access_token')).called(1);
    verify(mockLocalDatasource.deleteData('user')).called(1);
  });

  test('should throw exception when logout if the account is null', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleReturnsNull(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );
    expect(() async => await dataSource.logOut(), throwsException);
  });

  test('should throw unexpected exception when logout', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleThrowsException(),
      firebaseAuthInstance: mockFirebaseAuth,
      dio: mockDio,
      localDatasource: mockLocalDatasource,
    );
    expect(() async => await dataSource.logOut(), throwsException);
  });
}
