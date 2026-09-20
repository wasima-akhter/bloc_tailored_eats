import '../../domain/entities/friend.dart';
import '../../domain/entities/friend_request.dart';
import '../../domain/repositories/friends_repository.dart';
import '../datasources/friends_remote_datasource.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  final FriendsRemoteDataSource remoteDataSource;

  const FriendsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Friend>> getFriendSuggestions({
    String? search,
    int page = 1,
    int limit = 20,
  }) {
    return remoteDataSource.getFriendSuggestions(
      search: search,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<void> addFriend({required String friendId}) {
    return remoteDataSource.addFriend(friendId: friendId);
  }

  @override
  Future<List<Friend>> searchFriend({required String searchName}) {
    return remoteDataSource.searchFriend(searchName: searchName);
  }

  @override
  Future<Friend> getFriendDetail({required String userId}) {
    return remoteDataSource.getFriendDetail(userId: userId);
  }

  @override
  Future<List<FriendRequest>> getFriendRequests() {
    return remoteDataSource.getFriendRequests();
  }

  @override
  Future<void> acceptFriendRequest({required String requestId}) {
    return remoteDataSource.acceptFriendRequest(requestId: requestId);
  }

  @override
  Future<void> rejectFriendRequest({required String requestId}) {
    return remoteDataSource.rejectFriendRequest(requestId: requestId);
  }

  @override
  Future<void> unfriend({required String friendId}) {
    return remoteDataSource.unfriend(friendId: friendId);
  }

  @override
  Future<List<Friend>> getAllFriends() {
    return remoteDataSource.getAllFriends();
  }
}
