import '../entities/friend.dart';
import '../repositories/friends_repository.dart';

class SearchFriend {
  final FriendsRepository repository;

  const SearchFriend(this.repository);

  Future<List<Friend>> call({required String searchName}) {
    return repository.searchFriend(searchName: searchName);
  }
}
