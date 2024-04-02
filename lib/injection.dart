// All the dependency injections codes will go here (i.e. GetIt, Injectable)
// https://blog.logrocket.com/dependency-injection-flutter-using-getit-injectable/
// ignore_for_file: lines_longer_than_80_chars

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';
import 'package:talacare/data/datasources/auth_remote_datasource.dart';
import 'package:talacare/data/repositories/auth_repository_impl.dart';
import 'package:talacare/domain/repositories/auth_repository.dart';
import 'package:talacare/domain/usecases/auth_usecase.dart';
import 'package:talacare/presentation/providers/auth_provider.dart' as provider;

final getIt = GetIt.instance;

Future<void> init() async {
  // Provider
  getIt.registerLazySingleton(() => provider.AuthProvider(useCase: getIt()));

  // Use cases
  getIt.registerLazySingleton(() => AuthUseCase(getIt()));

  // Repository
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt(), getIt()));

  // Data source
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(googleSignIn: getIt(), firebaseAuthInstance: getIt(), dio: getIt(), localDatasource: getIt()));

  getIt.registerLazySingleton<AuthLocalDatasource>(() => AuthLocalDatasourceImpl(storage: getIt()));

  // External
  getIt.registerLazySingleton(() => GoogleSignIn());
  getIt.registerLazySingleton(() => FirebaseAuth.instance);
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
}
