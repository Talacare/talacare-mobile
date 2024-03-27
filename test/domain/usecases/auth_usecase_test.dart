import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthRepository])
void main() {
  late AuthUseCase useCase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    useCase = AuthUseCase(mockAuthRepository);
  });

  test('should get user entity from auth repository',
      () async {
    const userEntity = UserEntity(
        email: 'test@example.com',
        name: 'Test User',
        photoURL: 'https://example.com/photo.jpg');
    when(mockAuthRepository.signInGoogle()).thenAnswer((_) async => userEntity);

    final result = await useCase.signInGoogle();

    expect(result, equals(userEntity));
  });
}
