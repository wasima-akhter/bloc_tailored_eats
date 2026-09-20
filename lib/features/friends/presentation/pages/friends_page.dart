import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/friend.dart';
import '../../domain/entities/friend_request.dart';
import '../bloc/friends_cubit.dart';
import '../bloc/friends_state.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FriendsCubit>()..loadFriends(),
      child: const _FriendsView(),
    );
  }
}

class _FriendsView extends StatefulWidget {
  const _FriendsView();

  @override
  State<_FriendsView> createState() => _FriendsViewState();
}

class _FriendsViewState extends State<_FriendsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Friends'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Suggestions'),
            Tab(text: 'Friends'),
            Tab(text: 'Requests'),
          ],
        ),
      ),
      body: BlocBuilder<FriendsCubit, FriendsState>(
        builder: (context, state) {
          if (state is FriendsLoading) {
            return const AppLoader();
          }

          if (state is FriendsFailure) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<FriendsCubit>().loadFriends();
              },
            );
          }

          if (state is FriendsLoaded || state is FriendsActionLoading) {
            final suggestions = state is FriendsLoaded
                ? state.suggestions
                : (state as FriendsActionLoading).suggestions;

            final friends = state is FriendsLoaded
                ? state.friends
                : (state as FriendsActionLoading).friends;

            final requests = state is FriendsLoaded
                ? state.requests
                : (state as FriendsActionLoading).requests;

            final isLoading = state is FriendsActionLoading;

            return TabBarView(
              controller: _tabController,
              children: [
                _buildSuggestions(context, suggestions, isLoading),
                _buildFriends(context, friends, isLoading),
                _buildRequests(context, requests, isLoading),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSuggestions(
    BuildContext context,
    List<Friend> suggestions,
    bool isLoading,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              context.read<FriendsCubit>().search(query: value);
            },
            decoration: const InputDecoration(
              hintText: 'Search friends',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: suggestions.isEmpty
              ? const Center(child: Text('No friend suggestions found.'))
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: suggestions.length,
                  separatorBuilder: (_, _) => const Divider(),
                  itemBuilder: (context, index) {
                    final friend = suggestions[index];

                    return _FriendTile(
                      friend: friend,
                      trailing: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                context.read<FriendsCubit>().sendFriendRequest(
                                  friendId: friend.id,
                                );
                              },
                        child: const Text('Add'),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFriends(
    BuildContext context,
    List<Friend> friends,
    bool isLoading,
  ) {
    if (friends.isEmpty) {
      return const Center(child: Text('No friends found.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: friends.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final friend = friends[index];

        return _FriendTile(
          friend: friend,
          trailing: IconButton(
            onPressed: isLoading
                ? null
                : () {
                    context.read<FriendsCubit>().removeFriend(
                      friendId: friend.id,
                    );
                  },
            icon: const Icon(Icons.person_remove_outlined),
          ),
        );
      },
    );
  }

  Widget _buildRequests(
    BuildContext context,
    List<FriendRequest> requests,
    bool isLoading,
  ) {
    if (requests.isEmpty) {
      return const Center(child: Text('No friend requests found.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      separatorBuilder: (_, _) => const Divider(),
      itemBuilder: (context, index) {
        final request = requests[index];

        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            request.senderName.isEmpty ? 'Friend request' : request.senderName,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<FriendsCubit>().acceptRequest(
                          requestId: request.id,
                        );
                      },
                icon: const Icon(Icons.check),
              ),
              IconButton(
                onPressed: isLoading
                    ? null
                    : () {
                        context.read<FriendsCubit>().rejectRequest(
                          requestId: request.id,
                        );
                      },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FriendTile extends StatelessWidget {
  const _FriendTile({required this.friend, required this.trailing});

  final Friend friend;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Text(
          friend.name.isNotEmpty ? friend.name[0].toUpperCase() : '?',
        ),
      ),
      title: Text(
        friend.name.isEmpty
            ? '${friend.firstName} ${friend.lastName}'.trim()
            : friend.name,
      ),
      subtitle: Text(friend.email),
      trailing: trailing,
    );
  }
}
