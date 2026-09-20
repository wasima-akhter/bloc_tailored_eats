import '../entities/goal.dart';
import '../repositories/goals_repository.dart';

class UpdateGoal {
  final GoalsRepository repository;

  const UpdateGoal(this.repository);

  Future<Goal> call({
    required String goalId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) {
    return repository.updateGoal(
      goalId: goalId,
      title: title,
      description: description,
      type: type,
      dueDate: dueDate,
    );
  }
}
