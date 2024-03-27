import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/data/models/user_model.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

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

void main() {
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockFirebaseAuth = MockFirebaseAuth();
  });

  test('should return UserModel on successful sign-in', () async {
    final dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: MockGoogleSignIn(),
      firebaseAuthInstance: mockFirebaseAuth,
    );
    final result = await dataSource.signInGoogle();

    expect(result, isA<UserModel>());
  });

  test('should throw exception when the account is null', () async {
    final dataSource = AuthRemoteDatasourceImpl(
        googleSignIn: MockGoogleSignInReturnsNull(),
        firebaseAuthInstance: mockFirebaseAuth);
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });

  test('should throw unexpected exception', () async {
    final dataSource = AuthRemoteDatasourceImpl(
        googleSignIn: MockGoogleSignInThrowsException(),
        firebaseAuthInstance: mockFirebaseAuth);
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });
}
