import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/friend_model.dart';
import '../models/friend_request_model.dart';

abstract class FriendsRemoteDataSource {
  Future<List<FriendModel>> getFriendSuggestions({
    String? search,
    int page,
    int limit,
  });

  Future<void> addFriend({required String userId});

  Future<List<FriendModel>> searchFriend({required String searchName});

  Future<FriendModel> getFriendDetail({required String userId});

  Future<List<FriendRequestModel>> getFriendRequests();

  Future<void> acceptFriendRequest({required String requestId});

  Future<void> rejectFriendRequest({required String requestId});

  Future<void> unfriend({required String friendId});

  Future<List<FriendModel>> getAllFriends();
}

class FriendsRemoteDataSourceImpl implements FriendsRemoteDataSource {
  final ApiClient apiClient;

  const FriendsRemoteDataSourceImpl({required this.apiClient});

  List<Map<String, dynamic>> _extractList(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) {
      return [];
    }

    final data = responseData['data'];

    if (data is List) {
      return data.whereType<Map<String, dynamic>>().toList();
    }

    if (data is Map<String, dynamic>) {
      final list =
          data['friends'] ??
          data['suggestions'] ??
          data['requests'] ??
          data['data'];

      if (list is List) {
        return list.whereType<Map<String, dynamic>>().toList();
      }
    }

    return [];
  }

  Map<String, dynamic> _extractData(dynamic responseData) {
    if (responseData is! Map<String, dynamic>) {
      return {};
    }

    final data = responseData['data'];

    if (data is Map<String, dynamic>) {
      return data;
    }

    return {};
  }

  @override
  Future<List<FriendModel>> getFriendSuggestions({
    String? search,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await apiClient.dio.get(
      ApiEndpoints.getFriendSuggestions,
      queryParameters: {
        'page': page,
        'limit': limit,
        if (search != null && search.trim().isNotEmpty) 'search': search.trim(),
      },
    );

    return _extractList(response.data).map(FriendModel.fromJson).toList();
  }

  @override
  Future<void> addFriend({required String userId}) async {
    await apiClient.dio.post(ApiEndpoints.addFriend, data: {'userId': userId});
  }

  @override
  Future<List<FriendModel>> searchFriend({required String searchName}) async {
    final response = await apiClient.dio.get(
      ApiEndpoints.searchFriend,
      queryParameters: {'searchName': searchName},
    );

    return _extractList(response.data).map(FriendModel.fromJson).toList();
  }

  @override
  Future<FriendModel> getFriendDetail({required String userId}) async {
    final response = await apiClient.dio.get(
      '${ApiEndpoints.friendDetail}/$userId',
    );

    return FriendModel.fromJson(_extractData(response.data));
  }

  @override
  Future<List<FriendRequestModel>> getFriendRequests() async {
    final response = await apiClient.dio.get(ApiEndpoints.getAllFriendRequest);

    return _extractList(
      response.data,
    ).map(FriendRequestModel.fromJson).toList();
  }

  @override
  Future<void> acceptFriendRequest({required String requestId}) async {
    await apiClient.dio.patch(
      ApiEndpoints.acceptRequest,
      data: {'requestId': requestId},
    );
  }

  @override
  Future<void> rejectFriendRequest({required String requestId}) async {
    await apiClient.dio.patch(
      ApiEndpoints.rejectRequest,
      data: {'requestId': requestId},
    );
  }

  @override
  Future<void> unfriend({required String friendId}) async {
    await apiClient.dio.delete('${ApiEndpoints.makeUnfriend}/$friendId');
  }

  @override
  Future<List<FriendModel>> getAllFriends() async {
    final response = await apiClient.dio.get(ApiEndpoints.getAllFriend);

    return _extractList(response.data).map(FriendModel.fromJson).toList();
  }
}
