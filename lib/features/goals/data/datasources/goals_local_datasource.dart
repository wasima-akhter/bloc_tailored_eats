import '../models/goal_model.dart';

abstract class GoalsLocalDataSource {
  Future<List<GoalModel>> getAllGoals();

  Future<void> saveGoals(List<GoalModel> goals);

  Future<void> saveGoal(GoalModel goal);

  Future<void> deleteGoal(String goalId);

  Future<void> clearGoals();
}
