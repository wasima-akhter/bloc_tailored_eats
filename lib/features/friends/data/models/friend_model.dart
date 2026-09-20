import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/friend.dart';

class FriendModel extends Friend {
  const FriendModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.profileImage,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    final firstName = JsonParser.string(json['firstName']);

    final lastName = JsonParser.string(json['lastName']);

    return FriendModel(
      id: JsonParser.string(json['_id'] ?? json['id']),
      name: JsonParser.string(
        json['name'],
        fallback: '$firstName $lastName'.trim(),
      ),
      firstName: firstName,
      lastName: lastName,
      email: JsonParser.string(json['email']),
      profileImage: JsonParser.string(
        json['profileImage'] ?? json['profile_image'] ?? json['profilePicture'],
      ),
    );
  }
}
