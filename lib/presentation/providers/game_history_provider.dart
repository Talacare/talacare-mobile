import 'package:flutter/material.dart';
import 'package:talacare/domain/entities/game_history_entity.dart';
import 'package:talacare/domain/usecases/game_history_usecase.dart';

class GameHistoryProvider extends ChangeNotifier {
  final GameHistoryUseCase useCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  String _message = '';
  String get message => _message;

  GameHistoryProvider({required this.useCase});

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setError(bool isError, [String? message]) {
    _isError = isError;
    if (message != null) {
      _message = message;
    }
    notifyListeners();
  }

  void setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  Future<void> createGameHistory(GameHistoryEntity gameHistory) async {
    try {
      setLoading(true);
      setError(false);
      setMessage('');

      await useCase.createGameHistory(gameHistory);
      setMessage('Game history berhasil dibuat');
      setLoading(false);
    } catch (e) {
      debugPrint(e.toString());
      setMessage(e.toString());
      setError(true, '$e');
      setLoading(false);
    }
  }
}
