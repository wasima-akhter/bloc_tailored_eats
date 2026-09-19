import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;

  const AuthUser({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, firstName, lastName, email];
}
