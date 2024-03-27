import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(
    [MockSpec<AuthUseCase>(onMissingStub: OnMissingStub.returnDefault)])
void main() {
  late AuthProvider authProvider;
  late MockAuthUseCase mockAuthUseCase;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    authProvider = AuthProvider(useCase: mockAuthUseCase);
  });

  test('should set user model when signInGoogle is successful', () async {
    const userEntity = UserEntity(
      email: 'test@example.com',
      name: 'Test User',
      photoURL: 'https://example.com/photo.jpg',
    );
    when(mockAuthUseCase.signInGoogle()).thenAnswer((_) async => userEntity);

    await authProvider.signInWithGoogle();

    expect(authProvider.user, equals(userEntity));
  });

  test('should set isLoading to true when signInGoogle is called', () async {
    when(mockAuthUseCase.signInGoogle())
        .thenAnswer((_) async => const UserEntity(
              email: 'test@example.com',
              name: 'Test User',
              photoURL: 'https://example.com/photo.jpg',
            ));

    authProvider.signInWithGoogle();

    expect(authProvider.isLoading, true);
  });

  test('should set isLoading to false when signInGoogle succeeds', () async {
    when(mockAuthUseCase.signInGoogle())
        .thenAnswer((_) async => const UserEntity(
              email: 'test@example.com',
              name: 'Test User',
              photoURL: 'https://example.com/photo.jpg',
            ));

    await authProvider.signInWithGoogle();

    expect(authProvider.isLoading, false);
  });

  test('should set isError to true when signInGoogle fails', () async {
    when(mockAuthUseCase.signInGoogle()).thenThrow(Exception('Failed'));

    await authProvider.signInWithGoogle();

    expect(authProvider.isError, true);
  });

  test('should set isLoading to false when signInGoogle fails', () async {
    when(mockAuthUseCase.signInGoogle()).thenThrow(Exception('Failed'));

    await authProvider.signInWithGoogle();

    expect(authProvider.isLoading, false);
  });
}
