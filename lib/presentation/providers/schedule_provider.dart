import 'package:flutter/material.dart';
import 'package:talacare/domain/entities/schedule_entity.dart';
import 'package:talacare/domain/usecases/schedule_usecase.dart';

class ScheduleProvider extends ChangeNotifier {
  final ScheduleUseCase useCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isError = false;
  bool get isError => _isError;

  String _message = '';
  String get message => _message;

  List<Map<String, String>> _schedules = [];
  List<Map<String, String>> get schedules => _schedules;

  ScheduleProvider({required this.useCase});

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

  void setSchedules(List<Map<String, String>> schedules) {
    _schedules = schedules;
    notifyListeners();
  }

  Future<void> createSchedule(ScheduleEntity schedule) async {
    try {
      setLoading(true);
      setError(false);
      setMessage('');
      await useCase.createSchedule(schedule);
      setMessage('Jadwal berhasil dibuat');
      setLoading(false);
    } catch (e) {
      debugPrint(e.toString());
      setMessage(e.toString());
      setError(true, '$e');
      setLoading(false);
    }
  }

  Future<void> getSchedulesByUserId() async {
    try {
      setLoading(true);
      setError(false);
      final formattedSchedules = await useCase.getSchedulesByUserId();
      setSchedules(formattedSchedules);
      setLoading(false);
    } catch (e) {
      debugPrint(e.toString());
      setError(true, '$e');
      setLoading(false);

      throw Exception('Failed to get schedules: $e');
    }
  }
}
