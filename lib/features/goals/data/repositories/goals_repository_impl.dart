import '../../../../core/network/network_info.dart';
import '../../domain/entities/goal.dart';
import '../../domain/repositories/goals_repository.dart';
import '../datasources/goals_local_datasource.dart';
import '../datasources/goals_remote_datasource.dart';
/*
class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsRemoteDataSource remoteDataSource;

  const GoalsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Goal> createGoal({
    required String userId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) {
    return remoteDataSource.createGoal(
      userId: userId,
      title: title,
      description: description,
      type: type,
      dueDate: dueDate,
    );
  }

  @override
  Future<List<Goal>> getAllGoals() {
    return remoteDataSource.getAllGoals();
  }

  @override
  Future<void> markGoalCompleted({required String goalId}) {
    return remoteDataSource.markGoalCompleted(goalId: goalId);
  }

  @override
  Future<Goal> updateGoal({
    required String goalId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) {
    return remoteDataSource.updateGoal(
      goalId: goalId,
      title: title,
      description: description,
      type: type,
      dueDate: dueDate,
    );
  }

  @override
  Future<void> deleteGoal({required String goalId}) {
    return remoteDataSource.deleteGoal(goalId: goalId);
  }

  @override
  Future<Goal> changeGoalType({required String goalId, required String type}) {
    return remoteDataSource.changeGoalType(goalId: goalId, type: type);
  }

  @override
  Future<double> getCompletedGoalPercentage() {
    return remoteDataSource.getCompletedGoalPercentage();
  }
}
*/

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsRemoteDataSource remoteDataSource;
  final GoalsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  const GoalsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Goal> createGoal({
    required String userId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      throw Exception(
        'You are offline. Goal creation will be added with sync queue.',
      );
    }

    final goal = await remoteDataSource.createGoal(
      userId: userId,
      title: title,
      description: description,
      type: type,
      dueDate: dueDate,
    );

    await localDataSource.saveGoal(goal);

    return goal;
  }

  @override
  Future<List<Goal>> getAllGoals() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        final goals = await remoteDataSource.getAllGoals();

        await localDataSource.saveGoals(goals);

        return goals;
      } catch (_) {
        return localDataSource.getAllGoals();
      }
    }

    return localDataSource.getAllGoals();
  }

  @override
  Future<void> markGoalCompleted({required String goalId}) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      throw Exception(
        'You are offline. Goal completion sync will be added next.',
      );
    }

    await remoteDataSource.markGoalCompleted(goalId: goalId);

    final goals = await remoteDataSource.getAllGoals();

    await localDataSource.saveGoals(goals);
  }

  @override
  Future<Goal> updateGoal({
    required String goalId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      throw Exception('You are offline. Goal update sync will be added next.');
    }

    final goal = await remoteDataSource.updateGoal(
      goalId: goalId,
      title: title,
      description: description,
      type: type,
      dueDate: dueDate,
    );

    await localDataSource.saveGoal(goal);

    return goal;
  }

  @override
  Future<void> deleteGoal({required String goalId}) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      throw Exception(
        'You are offline. Goal deletion sync will be added next.',
      );
    }

    await remoteDataSource.deleteGoal(goalId: goalId);

    await localDataSource.deleteGoal(goalId);
  }

  @override
  Future<Goal> changeGoalType({
    required String goalId,
    required String type,
  }) async {
    final isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      throw Exception('You are offline. Goal type sync will be added next.');
    }

    final goal = await remoteDataSource.changeGoalType(
      goalId: goalId,
      type: type,
    );

    await localDataSource.saveGoal(goal);

    return goal;
  }

  @override
  Future<double> getCompletedGoalPercentage() async {
    final isConnected = await networkInfo.isConnected;

    if (isConnected) {
      try {
        return await remoteDataSource.getCompletedGoalPercentage();
      } catch (_) {
        return _calculateLocalPercentage();
      }
    }

    return _calculateLocalPercentage();
  }

  Future<double> _calculateLocalPercentage() async {
    final goals = await localDataSource.getAllGoals();

    if (goals.isEmpty) {
      return 0;
    }

    final completedCount = goals.where((goal) => goal.isCompleted).length;

    return (completedCount / goals.length) * 100;
  }
}
