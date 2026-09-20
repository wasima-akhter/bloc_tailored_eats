import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/friend.dart';
import '../../domain/entities/friend_request.dart';
import '../../domain/usecases/accept_friend_request.dart';
import '../../domain/usecases/add_friend.dart';
import '../../domain/usecases/get_all_friends.dart';
import '../../domain/usecases/get_friend_requests.dart';
import '../../domain/usecases/get_friend_suggestions.dart';
import '../../domain/usecases/reject_friend_request.dart';
import '../../domain/usecases/search_friend.dart';
import '../../domain/usecases/unfriend.dart';
import 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  final GetFriendSuggestions getFriendSuggestions;
  final AddFriend addFriend;
  final SearchFriend searchFriend;
  final GetFriendRequests getFriendRequests;
  final AcceptFriendRequest acceptFriendRequest;
  final RejectFriendRequest rejectFriendRequest;
  final Unfriend unfriend;
  final GetAllFriends getAllFriends;

  FriendsCubit({
    required this.getFriendSuggestions,
    required this.addFriend,
    required this.searchFriend,
    required this.getFriendRequests,
    required this.acceptFriendRequest,
    required this.rejectFriendRequest,
    required this.unfriend,
    required this.getAllFriends,
  }) : super(const FriendsInitial());

  Future<void> loadFriends() async {
    emit(const FriendsLoading());

    try {
      final results = await Future.wait([
        getFriendSuggestions(),
        getAllFriends(),
        getFriendRequests(),
      ]);

      emit(
        FriendsLoaded(
          suggestions: results[0] as List<Friend>,
          friends: results[1] as List<Friend>,
          requests: results[2] as List<FriendRequest>,
        ),
      );
    } catch (e) {
      emit(FriendsFailure(message: e.toString()));
    }
  }

  Future<void> search({required String query}) async {
    final currentState = state;

    if (currentState is! FriendsLoaded) {
      return;
    }

    if (query.trim().isEmpty) {
      emit(
        FriendsLoaded(
          suggestions: currentState.suggestions,
          friends: currentState.friends,
          requests: currentState.requests,
        ),
      );
      return;
    }

    try {
      final results = await searchFriend(searchName: query.trim());

      emit(
        FriendsLoaded(
          suggestions: results,
          friends: currentState.friends,
          requests: currentState.requests,
        ),
      );
    } catch (e) {
      emit(FriendsFailure(message: e.toString()));
    }
  }

  Future<void> sendFriendRequest({required String userId}) async {
    await _performAction(() async {
      await addFriend(userId: userId);
    });
  }

  Future<void> acceptRequest({required String requestId}) async {
    await _performAction(() async {
      await acceptFriendRequest(requestId: requestId);
    });
  }

  Future<void> rejectRequest({required String requestId}) async {
    await _performAction(() async {
      await rejectFriendRequest(requestId: requestId);
    });
  }

  Future<void> removeFriend({required String friendId}) async {
    await _performAction(() async {
      await unfriend(friendId: friendId);
    });
  }

  Future<void> _performAction(Future<void> Function() action) async {
    final currentState = state;

    if (currentState is! FriendsLoaded) {
      return;
    }

    emit(
      FriendsActionLoading(
        suggestions: currentState.suggestions,
        friends: currentState.friends,
        requests: currentState.requests,
      ),
    );

    try {
      await action();
      await loadFriends();
    } catch (e) {
      emit(FriendsFailure(message: e.toString()));
    }
  }
}
