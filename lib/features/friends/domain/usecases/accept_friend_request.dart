import '../repositories/friends_repository.dart';

class AcceptFriendRequest {
  final FriendsRepository repository;

  const AcceptFriendRequest(this.repository);

  Future<void> call({required String requestId}) {
    return repository.acceptFriendRequest(requestId: requestId);
  }
}
