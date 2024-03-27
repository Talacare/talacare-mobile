import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/data/models/user_model.dart';
import 'package:talacare/data/repositories/auth_repository_impl.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRemoteDatasource>(onMissingStub: OnMissingStub.returnDefault)
])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDatasource mockRemoteDatasource;
  const userModel = UserModel(
    email: 'test@example.com',
    name: 'Test User',
    photoURL: 'https://example.com/photo.jpg',
  );

  setUp(() {
    mockRemoteDatasource = MockAuthRemoteDatasource();
    repository = AuthRepositoryImpl(mockRemoteDatasource);
  });

  test('should call signInGoogle of auth remote datasource', () async {
    when(mockRemoteDatasource.signInGoogle())
        .thenAnswer((_) async => userModel);

    final result = await repository.signInGoogle();

    expect(result, equals(userModel));
    verify(mockRemoteDatasource.signInGoogle()).called(1);
  });
}
