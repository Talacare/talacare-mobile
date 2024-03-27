import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> signInGoogle();
}

class AuthRemoteDatasourceImpl extends AuthRemoteDatasource {
  GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuthInstance;

  AuthRemoteDatasourceImpl({
    required this.googleSignIn,
    required this.firebaseAuthInstance,
  });

  @override
  Future<UserModel> signInGoogle() async {
    return await processSignInGoogle();
  }

  Future<UserModel> processSignInGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account == null) {
        throw Exception('Google sign-in aborted');
      }

      final GoogleSignInAuthentication authentication =
          await account.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      final UserCredential userCredential =
          await firebaseAuthInstance.signInWithCredential(credential);

      final User user = userCredential.user!;
      final UserModel userModel = UserModel(
        email: user.email ?? '-',
        name: user.displayName ?? '-',
        photoURL: user.photoURL ??
            'https://i.pinimg.com/564x/87/14/55/8714556a52021ba3a55c8e7a3547d28c.jpg',
      );

      return userModel;
    } catch (e) {
      throw Exception('Sign-in failed: $e');
    }
  }
}
