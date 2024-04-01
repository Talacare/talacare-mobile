import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:talacare/data/datasources/auth_local_datasource.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signInGoogle();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  final authAPI = '${dotenv.env['API_URL']!}/auth';
  Dio dio;
  GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuthInstance;
  AuthLocalDatasource localDatasource;

  AuthRemoteDatasourceImpl({
    required this.googleSignIn,
    required this.firebaseAuthInstance,
    required this.dio,
    required this.localDatasource,
  });

  @override
  Future<UserModel> signInGoogle() async {
    try {
      final GoogleSignInAccount? account = await _signInWithGoogle();
      final User user = await _authenticateWithFirebase(account!);
      final UserModel userModel = _createUserModel(user);
      await _storeToStorage(user, userModel);
      return userModel;
    } catch (e) {
      throw Exception('Sign-in failed: $e');
    }
  }

  Future<GoogleSignInAccount?> _signInWithGoogle() async {
    final GoogleSignInAccount? account = await googleSignIn.signIn();
    if (account == null) {
      throw Exception('Google sign-in aborted');
    }
    return account;
  }

  Future<User> _authenticateWithFirebase(GoogleSignInAccount account) async {
    final GoogleSignInAuthentication authentication =
        await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );
    final UserCredential userCredential =
        await firebaseAuthInstance.signInWithCredential(credential);
    return userCredential.user!;
  }

  UserModel _createUserModel(User user) {
    return UserModel(
      email: user.email ?? '-',
      name: user.displayName ?? '-',
      photoURL: user.photoURL ??
          'https://i.pinimg.com/564x/87/14/55/8714556a52021ba3a55c8e7a3547d28c.jpg',
    );
  }

  Future<void> _storeToStorage(User user, UserModel userModel) async {
    final token = await user.getIdToken();
    final response = await dio.get(authAPI,
        options: Options(headers: {'Authorization': token}));
    await localDatasource.storeData('access_token', response.data["token"]);
    await localDatasource.storeData('user', json.encode(userModel));
  }
}
