// All the dependency injections codes will go here (i.e. GetIt, Injectable)
// https://blog.logrocket.com/dependency-injection-flutter-using-getit-injectable/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));

  // Data source
  getIt.registerLazySingleton<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(googleSignIn: getIt(), firebaseAuthInstance: getIt()));

  // External
  final googleSignIn = GoogleSignIn();
  getIt.registerLazySingleton(() => googleSignIn);
  final firebaseAuthInstance = FirebaseAuth.instance;
  getIt.registerLazySingleton(() => firebaseAuthInstance);
}