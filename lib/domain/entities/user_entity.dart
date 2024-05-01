import 'package:equatable/equatable.dart';
import 'package:talacare/core/enums/user_role.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.email,
    required this.name,
    required this.photoURL,
    required this.role,
  });

  final String email;
  final String name;
  final String photoURL;
  final UserRole role;

  @override
  List<Object?> get props => [
        email,
        name,
        photoURL,
        role,
      ];
}
