import '../../domain/entities/goal.dart';
import '../../domain/repositories/goals_repository.dart';
import '../datasources/goals_remote_datasource.dart';

class GoalsRepositoryImpl implements GoalsRepository {
  final GoalsRemoteDataSource remoteDataSource;

  const GoalsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Goal> createGoal({
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) {
    return remoteDataSource.createGoal(
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
