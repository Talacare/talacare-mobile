import 'package:talacare/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.email,
    required super.name,
    required super.photoURL,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    email: json["email"],
    name: json["name"],
    photoURL: json["photoURL"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "name": name,
    "photoURL": photoURL,
  };
}