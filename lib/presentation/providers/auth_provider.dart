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

  Future<void> signInWithGoogle() async {
    try {
      setLoading(true);

      _user = await useCase.signInGoogle();
      notifyListeners();

      setLoading(false);
    } catch (e) {
      setLoading(false);

      _isError = true;
      notifyListeners();
    }
  }
}
