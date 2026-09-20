import '../entities/friend.dart';
import '../repositories/friends_repository.dart';

class GetAllFriends {
  final FriendsRepository repository;

  const GetAllFriends(this.repository);

  Future<List<Friend>> call() {
    return repository.getAllFriends();
  }
}
