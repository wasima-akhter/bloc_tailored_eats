import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/friend_request.dart';

class FriendRequestModel extends FriendRequest {
  const FriendRequestModel({
    required super.id,
    required super.senderId,
    required super.senderName,
    required super.senderImage,
  });

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) {
    final sender = json['sender'] is Map<String, dynamic>
        ? json['sender'] as Map<String, dynamic>
        : <String, dynamic>{};

    return FriendRequestModel(
      id: JsonParser.string(json['_id'] ?? json['id']),
      senderId: JsonParser.string(
        json['senderId'] ?? json['userId'] ?? sender['_id'] ?? sender['id'],
      ),
      senderName: JsonParser.string(
        json['senderName'] ?? json['name'] ?? sender['name'],
      ),
      senderImage: JsonParser.string(
        json['senderImage'] ??
            json['profileImage'] ??
            sender['profileImage'] ??
            sender['profile_image'],
      ),
    );
  }
}
