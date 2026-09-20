import '../entities/friend.dart';
import '../repositories/friends_repository.dart';

class GetFriendSuggestions {
  final FriendsRepository repository;

  const GetFriendSuggestions(this.repository);

  Future<List<Friend>> call({String? search, int page = 1, int limit = 20}) {
    return repository.getFriendSuggestions(
      search: search,
      page: page,
      limit: limit,
    );
  }
}
