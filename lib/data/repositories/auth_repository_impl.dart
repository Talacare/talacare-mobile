import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/domain/entities/user_entity.dart';
import 'package:talacare/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource);

  @override
  Future<UserEntity> signInGoogle() async {
    return await authRemoteDatasource.signInGoogle();
  }
}
