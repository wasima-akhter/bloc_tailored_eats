import '../entities/goal.dart';

abstract class GoalsRepository {
  Future<Goal> createGoal({
    required String title,
    required String description,
    required String type,
    required String dueDate,
  });

  Future<List<Goal>> getAllGoals();

  Future<void> markGoalCompleted({required String goalId});

  Future<Goal> updateGoal({
    required String goalId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  });

  Future<void> deleteGoal({required String goalId});

  Future<Goal> changeGoalType({required String goalId, required String type});

  Future<double> getCompletedGoalPercentage();
}
