import 'package:flutter_test/flutter_test.dart';
import 'package:talacare/domain/entities/user_entity.dart';

void main() {
  const user = UserEntity(
    email: 'test@example.com',
    name: 'Test User',
    photoURL: 'https://example.com/photo.jpg',
  );

  test('UserEntity instances with the same properties should be equal', () {
    const otherUser = UserEntity(
      email: 'test@example.com',
      name: 'Test User',
      photoURL: 'https://example.com/photo.jpg',
    );

    expect(user, equals(otherUser));
  });

  test('UserEntity instances with different properties should not be equal',
      () {
    const otherUser = UserEntity(
      email: 'test2@example.com',
      name: 'Test User 2',
      photoURL: 'https://example.com/photo2.jpg',
    );
    expect(user, isNot(equals(otherUser)));
  });

  test(
    'UserEntity should generate correct list of props',
    () {
      expect(
        user.props,
        equals(
          ['test@example.com', 'Test User', 'https://example.com/photo.jpg'],
        ),
      );
    },
  );
}