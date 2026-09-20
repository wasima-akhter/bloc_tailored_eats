import 'package:equatable/equatable.dart';

class FriendRequest extends Equatable {
  final String id;
  final String senderId;
  final String senderName;
  final String senderImage;

  const FriendRequest({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.senderImage,
  });

  @override
  List<Object?> get props => [id, senderId, senderName, senderImage];
}
