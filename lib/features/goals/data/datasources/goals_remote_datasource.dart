import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/goal_model.dart';

abstract class GoalsRemoteDataSource {
  Future<GoalModel> createGoal({
    required String userId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  });

  Future<List<GoalModel>> getAllGoals();

  Future<void> markGoalCompleted({required String goalId});

  Future<GoalModel> updateGoal({
    required String goalId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  });

  Future<void> deleteGoal({required String goalId});

  Future<GoalModel> changeGoalType({
    required String goalId,
    required String type,
  });

  Future<double> getCompletedGoalPercentage();
}

class GoalsRemoteDataSourceImpl implements GoalsRemoteDataSource {
  final ApiClient apiClient;

  const GoalsRemoteDataSourceImpl({required this.apiClient});

  Map<String, dynamic> _data(dynamic responseData) {
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
  Future<GoalModel> createGoal({
    required String userId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) async {
    final response = await apiClient.dio.post(
      ApiEndpoints.createNewGoal,
      data: {'userId': userId, 'title': title},
    );

    return GoalModel.fromJson(_data(response.data));
  }

  @override
  Future<List<GoalModel>> getAllGoals() async {
    final response = await apiClient.dio.get(ApiEndpoints.getAllGoal);

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'];

    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(GoalModel.fromJson)
          .toList();
    }

    if (data is Map<String, dynamic>) {
      final goals = data['goals'] ?? data['data'];

      if (goals is List) {
        return goals
            .whereType<Map<String, dynamic>>()
            .map(GoalModel.fromJson)
            .toList();
      }
    }

    return [];
  }

  @override
  Future<void> markGoalCompleted({required String goalId}) async {
    await apiClient.dio.patch(
      ApiEndpoints.markGoalCompleted,
      data: {'goalId': goalId},
    );
  }

  @override
  Future<GoalModel> updateGoal({
    required String goalId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) async {
    final response = await apiClient.dio.patch(
      ApiEndpoints.updateGoal,
      data: {
        'goalId': goalId,
        'title': title,
        'description': description,
        'type': type,
        'dueDate': dueDate,
      },
    );

    return GoalModel.fromJson(_data(response.data));
  }

  @override
  Future<void> deleteGoal({required String goalId}) async {
    await apiClient.dio.delete('${ApiEndpoints.deleteGoal}/$goalId');
  }

  @override
  Future<GoalModel> changeGoalType({
    required String goalId,
    required String type,
  }) async {
    final response = await apiClient.dio.patch(
      ApiEndpoints.changeGoalType,
      data: {'goalId': goalId, 'type': type},
    );

    return GoalModel.fromJson(_data(response.data));
  }

  @override
  Future<double> getCompletedGoalPercentage() async {
    final response = await apiClient.dio.get(
      ApiEndpoints.completedGoalPercentage,
    );

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'];

    if (data is num) {
      return data.toDouble();
    }

    if (data is Map<String, dynamic>) {
      final value =
          data['percentage'] ??
          data['completedPercentage'] ??
          data['completionPercentage'];

      if (value is num) {
        return value.toDouble();
      }

      return double.tryParse(value?.toString() ?? '') ?? 0;
    }

    return double.tryParse(data?.toString() ?? '') ?? 0;
  }
}
