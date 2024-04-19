import 'package:equatable/equatable.dart';

class ScheduleEntity extends Equatable {
  const ScheduleEntity({
    this.id,
    required this.hour,
    required this.minute,
    this.userId,
  });

  final String? id;
  final int hour;
  final int minute;
  final String? userId;

  @override
  List<Object?> get props => [id, hour, minute, userId];
}
