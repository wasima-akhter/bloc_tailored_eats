import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImage;

  const Friend({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImage,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    firstName,
    lastName,
    email,
    profileImage,
  ];
}
