import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/data/models/schedule_model.dart';
import 'package:talacare/domain/entities/schedule_entity.dart';

void main() {
  const String id = 'unique-id-123';
  const int hour = 14;
  const int minute = 30;
  const String userId = 'user-id-456';

  const scheduleModel = ScheduleModel(
    id: id,
    hour: hour,
    minute: minute,
    userId: userId,
  );

  const json = {
    'id': id,
    'hour': hour,
    'minute': minute,
    'userId': userId,
  };

  test(
    'should be a subclass of ScheduleEntity',
    () async {
      expect(scheduleModel, isA<ScheduleEntity>());
    },
  );

  test('Initialization', () {
    expect(scheduleModel.id, id);
    expect(scheduleModel.hour, hour);
    expect(scheduleModel.minute, minute);
    expect(scheduleModel.userId, userId);
  });

  test('Serialization to JSON', () {
    final generatedJson = scheduleModel.toJson();

    expect(generatedJson['id'], id);
    expect(generatedJson['hour'], hour);
    expect(generatedJson['minute'], minute);
    expect(generatedJson['userId'], userId);
  });

  test('Deserialization from JSON', () {
    final deserializedModel = ScheduleModel.fromJson(json);

    expect(deserializedModel.id, id);
    expect(deserializedModel.hour, hour);
    expect(deserializedModel.minute, minute);
    expect(deserializedModel.userId, userId);
  });

  test('Deserialization from incomplete JSON', () {
    bool didThrowException = false;
    final incompleteJson = {'id': id, 'hour': hour, 'userId': userId};

    try {
      ScheduleModel.fromJson(incompleteJson);
    } catch (e) {
      didThrowException = true;
    }

    expect(didThrowException, isTrue);
  });
}
