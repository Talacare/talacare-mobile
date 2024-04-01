import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:talacare/domain/entities/user_entity.dart';
import 'package:talacare/domain/repositories/auth_repository.dart';
import 'package:talacare/domain/usecases/auth_usecase.dart';
import 'auth_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late AuthUseCase useCase;
  late MockAuthRepository mockAuthRepository;
  const userEntity = UserEntity(
      email: 'test@example.com',
      name: 'Test User',
      photoURL: 'https://example.com/photo.jpg');

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = AuthUseCase(mockAuthRepository);
  });

  test('should get user entity from auth repository (remote data source)', () async {
    when(mockAuthRepository.signInGoogle()).thenAnswer((_) async => userEntity);

    final result = await useCase.signInGoogle();

    expect(result, equals(userEntity));
  });

  test('should get user entity from auth repository (local data source)', () async {
    when(mockAuthRepository.getLocalStoredUser()).thenAnswer((_) async => userEntity);

    final result = await useCase.getLocalStoredUser();

    expect(result, equals(userEntity));
  });

  test('should get null from auth repository (local data source)', () async {
    when(mockAuthRepository.getLocalStoredUser()).thenAnswer((_) async => Future.value(null));

    final result = await useCase.getLocalStoredUser();

    expect(result, isNull);
  });
}
