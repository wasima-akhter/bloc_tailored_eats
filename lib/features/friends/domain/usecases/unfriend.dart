import '../repositories/friends_repository.dart';

class Unfriend {
  final FriendsRepository repository;

  const Unfriend(this.repository);

  Future<void> call({required String friendId}) {
    return repository.unfriend(friendId: friendId);
  }
}
