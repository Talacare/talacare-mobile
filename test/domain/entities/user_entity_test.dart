import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UserEntity instances with the same properties should be equal', () {
    const user1 = UserEntity(
      email: 'test@example.com',
      name: 'Test User',
      photoURL: 'https://example.com/photo.jpg',
    );
    const user2 = UserEntity(
      email: 'test@example.com',
      name: 'Test User',
      photoURL: 'https://example.com/photo.jpg',
    );

    expect(user1, equals(user2));
  });

  test('UserEntity instances with different properties should not be equal', () {
    const user1 = UserEntity(
      email: 'test1@example.com',
      name: 'Test User 1',
      photoURL: 'https://example.com/photo1.jpg',
    );
    const user2 = UserEntity(
      email: 'test2@example.com',
      name: 'Test User 2',
      photoURL: 'https://example.com/photo2.jpg',
    );

    expect(user1, isNot(equals(user2)));
  });

  test('UserEntity should generate correct list of props', () {
    const user = UserEntity(
      email: 'test@example.com',
      name: 'Test User',
      photoURL: 'https://example.com/photo.jpg',
    );

    expect(user.props, equals(['test@example.com', 'Test User', 'https://example.com/photo.jpg']));
  });
}
