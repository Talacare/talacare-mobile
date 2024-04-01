import 'dart:convert';

import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/data/models/user_model.dart';
import 'package:talacare/domain/entities/user_entity.dart';
import 'package:talacare/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  final AuthLocalDatasource authLocalDatasource;

  AuthRepositoryImpl(this.authRemoteDatasource, this.authLocalDatasource);

  @override
  Future<UserEntity> signInGoogle() async {
    return await authRemoteDatasource.signInGoogle();
  }

  @override
  Future<UserEntity?> getLocalStoredUser() async {
    final userJson = await authLocalDatasource.readData('user');

    if (userJson == null) return null;
    return UserModel.fromJson(json.decode(userJson));
  }
}
