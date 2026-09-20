import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/consistency_model.dart';
import '../models/user_weight_model.dart';

abstract class ConsistencyRemoteDataSource {
  Future<ConsistencyModel> getUserConsistency();

  Future<UserWeightModel> addUserWeight({required double weight});

  Future<List<UserWeightModel>> getUserWeight();
}

class ConsistencyRemoteDataSourceImpl implements ConsistencyRemoteDataSource {
  final ApiClient apiClient;

  const ConsistencyRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ConsistencyModel> getUserConsistency() async {
    final response = await apiClient.dio.get(
      ApiEndpoints.userConsistencyDetails,
    );

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'] as Map<String, dynamic>? ?? {};

    return ConsistencyModel.fromJson(data);
  }

  @override
  Future<UserWeightModel> addUserWeight({required double weight}) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.addUserWeight,
      data: {'weight': weight},
    );

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'] as Map<String, dynamic>? ?? {};

    return UserWeightModel.fromJson(data);
  }

  @override
  Future<List<UserWeightModel>> getUserWeight() async {
    final response = await apiClient.dio.get(ApiEndpoints.getUserWeight);

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'];

    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(UserWeightModel.fromJson)
          .toList();
    }

    if (data is Map<String, dynamic>) {
      final weights = data['weights'] ?? data['userWeights'] ?? data['data'];

      if (weights is List) {
        return weights
            .whereType<Map<String, dynamic>>()
            .map(UserWeightModel.fromJson)
            .toList();
      }
    }

    return [];
  }
}
