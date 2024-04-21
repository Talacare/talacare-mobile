import 'package:talacare/domain/entities/schedule_entity.dart';

class ScheduleModel extends ScheduleEntity {
  const ScheduleModel({
    super.id,
    required super.hour,
    required super.minute,
    super.userId,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json["id"],
        hour: json["hour"],
        minute: json["minute"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'hour': hour,
        'minute': minute,
        'userId': userId,
      };
}
