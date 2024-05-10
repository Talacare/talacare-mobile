import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/core/enums/user_role.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/data/models/user_model.dart';
import 'package:talacare/data/repositories/auth_repository_impl.dart';
import 'auth_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRemoteDatasource>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<AuthLocalDatasource>(onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late AuthRepositoryImpl repository;
  late MockAuthRemoteDatasource mockRemoteDatasource;
  late MockAuthLocalDatasource mockLocalDatasource;

  const userModel = UserModel(
    email: 'test@example.com',
    name: 'Test User',
    photoURL: 'https://example.com/photo.jpg',
    role: UserRole.USER,
  );

  setUp(() {
    mockRemoteDatasource = MockAuthRemoteDatasource();
    mockLocalDatasource = MockAuthLocalDatasource();
    repository = AuthRepositoryImpl(mockRemoteDatasource, mockLocalDatasource);
  });

  test('should call signInGoogle of auth remote datasource', () async {
    when(mockRemoteDatasource.signInGoogle())
        .thenAnswer((_) async => userModel);

    final result = await repository.signInGoogle();

    expect(result, equals(userModel));
    verify(mockRemoteDatasource.signInGoogle()).called(1);
  });

  test(
      'should call getLocalStoredUser of auth local datasource and return user model',
      () async {
    when(mockLocalDatasource.readData('user'))
        .thenAnswer((_) async => json.encode(userModel));

    final result = await repository.getLocalStoredUser();

    expect(result, equals(userModel));
    verify(mockLocalDatasource.readData('user')).called(1);
  });

  test(
      'should call getLocalStoredUser of auth local datasource and return null',
      () async {
    when(mockLocalDatasource.readData('user'))
        .thenAnswer((_) async => Future.value(null));

    final result = await repository.getLocalStoredUser();

    expect(result, isNull);
    verify(mockLocalDatasource.readData('user')).called(1);
  });

  test('should call logOut of auth remote datasource', () async {
    when(mockRemoteDatasource.logOut()).thenAnswer((_) async => Future.value());
    await repository.logOut();
    verify(mockRemoteDatasource.logOut()).called(1);
  });
}
