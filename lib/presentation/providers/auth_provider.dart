import 'package:flutter/foundation.dart';
import 'package:talacare/domain/usecases/auth_usecase.dart';

import '../../domain/entities/user_entity.dart';

class AuthProvider extends ChangeNotifier {
  final AuthUseCase useCase;

  UserEntity? _user;
  UserEntity? get user => _user;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  AuthProvider({required this.useCase});

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setUser(UserEntity? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    try {
      setLoading(true);

      final userEntity = await useCase.signInGoogle();
      setUser(userEntity);

      setLoading(false);
    } catch (e) {
      debugPrint(e.toString());
      setLoading(false);

      _isError = true;
      notifyListeners();
    }
  }

  Future<void> getLocalStoredUser() async {
    final userEntity = await useCase.getLocalStoredUser();
    setUser(userEntity);
  }
}
