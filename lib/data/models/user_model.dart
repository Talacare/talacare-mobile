import 'package:talacare/core/enums/user_role.dart';
import 'package:talacare/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.name,
    required super.photoURL,
    required super.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        name: json["name"],
        photoURL: json["photoURL"],
        role: json["role"] == 'USER' ? UserRole.USER : UserRole.ADMIN,
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "photoURL": photoURL,
        "role": role == UserRole.USER ? 'USER' : 'ADMIN',
      };
}
