import 'package:talacare/domain/repositories/auth_repository.dart';

import '../entities/user_entity.dart';

class AuthUseCase {
  final AuthRepository authRepository;

  AuthUseCase(this.authRepository);

  Future<UserEntity> signInGoogle() async {
    return await authRepository.signInGoogle();
  }
}
