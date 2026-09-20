import '../entities/goal.dart';
import '../repositories/goals_repository.dart';

class ChangeGoalType {
  final GoalsRepository repository;

  const ChangeGoalType(this.repository);

  Future<Goal> call({required String goalId, required String type}) {
    return repository.changeGoalType(goalId: goalId, type: type);
  }
}
