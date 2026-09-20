import '../entities/friend.dart';
import '../repositories/friends_repository.dart';

class GetFriendDetail {
  final FriendsRepository repository;

  const GetFriendDetail(this.repository);

  Future<Friend> call({required String userId}) {
    return repository.getFriendDetail(userId: userId);
  }
}
