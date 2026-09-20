import '../repositories/friends_repository.dart';

class AddFriend {
  final FriendsRepository repository;

  const AddFriend(this.repository);

  Future<void> call({required String userId}) {
    return repository.addFriend(userId: userId);
  }
}
