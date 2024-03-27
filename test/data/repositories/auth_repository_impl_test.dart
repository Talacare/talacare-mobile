import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<AuthRemoteDatasource>(onMissingStub: OnMissingStub.returnDefault)])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDatasource mockRemoteDatasource;

  setUp(() {
    mockRemoteDatasource = MockAuthRemoteDatasource();
    repository = AuthRepositoryImpl(mockRemoteDatasource);
  });

  test('should call signInGoogle of auth remote datasource', () async {
    const userModel = UserModel(
      email: 'test@example.com',
      name: 'Test User',
      photoURL: 'https://example.com/photo.jpg',
    );
    when(mockRemoteDatasource.signInGoogle())
        .thenAnswer((_) async => userModel);

    final result = await repository.signInGoogle();

    expect(result, equals(userModel));
    verify(mockRemoteDatasource.signInGoogle()).called(1);
  });
}
