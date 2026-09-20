import '../entities/goal.dart';
import '../repositories/goals_repository.dart';

class CreateGoal {
  final GoalsRepository repository;

  const CreateGoal(this.repository);

  Future<Goal> call({
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) {
    return repository.createGoal(
      title: title,
      description: description,
      type: type,
      dueDate: dueDate,
    );
  }
}
