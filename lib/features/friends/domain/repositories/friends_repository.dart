import '../entities/friend.dart';
import '../entities/friend_request.dart';

abstract class FriendsRepository {
  Future<List<Friend>> getFriendSuggestions({
    String? search,
    int page,
    int limit,
  });

  Future<void> addFriend({required String friendId});

  Future<List<Friend>> searchFriend({required String searchName});

  Future<Friend> getFriendDetail({required String userId});

  Future<List<FriendRequest>> getFriendRequests();

  Future<void> acceptFriendRequest({required String requestId});

  Future<void> rejectFriendRequest({required String requestId});

  Future<void> unfriend({required String friendId});

  Future<List<Friend>> getAllFriends();
}
