import 'package:talacare/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> signInGoogle();
  Future<UserEntity?> getLocalStoredUser();
  Future<void> logOut();
}
