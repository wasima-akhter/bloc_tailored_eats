import 'package:equatable/equatable.dart';

import '../../domain/entities/friend.dart';
import '../../domain/entities/friend_request.dart';

abstract class FriendsState extends Equatable {
  const FriendsState();

  @override
  List<Object?> get props => [];
}

class FriendsInitial extends FriendsState {
  const FriendsInitial();
}

class FriendsLoading extends FriendsState {
  const FriendsLoading();
}

class FriendsLoaded extends FriendsState {
  final List<Friend> suggestions;
  final List<Friend> friends;
  final List<FriendRequest> requests;

  const FriendsLoaded({
    required this.suggestions,
    required this.friends,
    required this.requests,
  });

  @override
  List<Object?> get props => [suggestions, friends, requests];
}

class FriendsActionLoading extends FriendsState {
  final List<Friend> suggestions;
  final List<Friend> friends;
  final List<FriendRequest> requests;

  const FriendsActionLoading({
    required this.suggestions,
    required this.friends,
    required this.requests,
  });

  @override
  List<Object?> get props => [suggestions, friends, requests];
}

class FriendsFailure extends FriendsState {
  final String message;

  const FriendsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
