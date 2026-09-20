import '../repositories/friends_repository.dart';

class RejectFriendRequest {
  final FriendsRepository repository;

  const RejectFriendRequest(this.repository);

  Future<void> call({required String requestId}) {
    return repository.rejectFriendRequest(requestId: requestId);
  }
}
