import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.email,
    required this.name,
    required this.photoURL,
  });

  final String email;
  final String name;
  final String photoURL;

  @override
  List<Object?> get props => [
    email,
    name,
    photoURL,
  ];
}