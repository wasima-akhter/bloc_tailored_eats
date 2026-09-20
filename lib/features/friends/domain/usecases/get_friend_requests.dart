import '../entities/friend_request.dart';
import '../repositories/friends_repository.dart';

class GetFriendRequests {
  final FriendsRepository repository;

  const GetFriendRequests(this.repository);

  Future<List<FriendRequest>> call() {
    return repository.getFriendRequests();
  }
}
