import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

class MockGoogleSignInV2 extends Mock implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() {
    return Future.value(null);
  }
}

class MockGoogleSignInV3 extends Mock implements MockGoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() {
    throw Exception();
  }
}

void main() {
  late AuthRemoteDatasourceImpl dataSource;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFirebaseAuth mockFirebaseAuth;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();

    mockGoogleSignIn = MockGoogleSignIn();
    mockFirebaseAuth = MockFirebaseAuth();
    dataSource = AuthRemoteDatasourceImpl(
      googleSignIn: mockGoogleSignIn,
      firebaseAuthInstance: mockFirebaseAuth,
    );
  });

  test('should return UserModel on successful sign-in', () async {
    final result = await dataSource.signInGoogle();

    expect(result, isA<UserModel>());
  });

  test('should throw exception when the account is null', () async {
    final dataSource = AuthRemoteDatasourceImpl(
        googleSignIn: MockGoogleSignInV2(),
        firebaseAuthInstance: mockFirebaseAuth);
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });

  test('should throw unexpected exception', () async {
    final dataSource = AuthRemoteDatasourceImpl(
        googleSignIn: MockGoogleSignInV3(),
        firebaseAuthInstance: mockFirebaseAuth);
    expect(() async => await dataSource.signInGoogle(), throwsException);
  });
}
