import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'should be a subclass of UserEntity',
    () async {
      const String email = 'test@example.com';
      const String name = 'Test User';
      const String photoURL = 'https://example.com/photo.jpg';

      const userModel = UserModel(
        email: email,
        name: name,
        photoURL: photoURL,
      );
      
      expect(userModel, isA<UserEntity>());
    },
  );

  test('Initialization', () {
    const String email = 'test@example.com';
    const String name = 'Test User';
    const String photoURL = 'https://example.com/photo.jpg';

    const userModel = UserModel(
      email: email,
      name: name,
      photoURL: photoURL,
    );

    expect(userModel.email, email);
    expect(userModel.name, name);
    expect(userModel.photoURL, photoURL);
  });

  test('Serialization to JSON', () {
    const String email = 'test@example.com';
    const String name = 'Test User';
    const String photoURL = 'https://example.com/photo.jpg';
    const userModel = UserModel(
      email: email,
      name: name,
      photoURL: photoURL,
    );

    final json = userModel.toJson();

    expect(json['email'], email);
    expect(json['name'], name);
    expect(json['photoURL'], photoURL);
  });

  test('Deserialization from JSON', () {
    const String email = 'test@example.com';
    const String name = 'Test User';
    const String photoURL = 'https://example.com/photo.jpg';
    final json = {
      'email': email,
      'name': name,
      'photoURL': photoURL,
    };

    final userModel = UserModel.fromJson(json);

    expect(userModel.email, email);
    expect(userModel.name, name);
    expect(userModel.photoURL, photoURL);
  });

  test('Deserialization from uncompleted JSON', () {
    const String email = 'test@example.com';
    const String name = 'Test User';
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
