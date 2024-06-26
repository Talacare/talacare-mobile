import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/core/enums/user_role.dart';
import 'package:talacare/data/models/user_model.dart';
import 'package:talacare/domain/entities/user_entity.dart';

void main() {
  const String email = 'test@example.com';
  const String name = 'Test User';
  const String photoURL = 'https://example.com/photo.jpg';
  const UserRole role = UserRole.USER;

  const userModel = UserModel(
    email: email,
    name: name,
    photoURL: photoURL,
    role: role,
  );

  const json = {
    'email': email,
    'name': name,
    'photoURL': photoURL,
    'role': 'USER',
  };

  test(
    'should be a subclass of UserEntity',
    () async {
      expect(userModel, isA<UserEntity>());
    },
  );

  test('Initialization', () {
    expect(userModel.email, email);
    expect(userModel.name, name);
    expect(userModel.photoURL, photoURL);
    expect(userModel.role, role);
  });

  test('Serialization to JSON', () {
    final json = userModel.toJson();

    expect(json['email'], email);
    expect(json['name'], name);
    expect(json['photoURL'], photoURL);
    expect(json['role'], 'USER');
  });

  test('Deserialization from JSON', () {
    final userModel = UserModel.fromJson(json);

    expect(userModel.email, email);
    expect(userModel.name, name);
    expect(userModel.photoURL, photoURL);
    expect(userModel.role, role);
  });

  test('Deserialization from uncompleted JSON', () {
    bool didThrowException = false;
    final json = {
      'email': email,
      'name': name,
    };

    try {
      UserModel.fromJson(json);
    } catch (e) {
      didThrowException = true;
    }

    expect(didThrowException, isTrue);
  });
}
