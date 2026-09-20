import '../repositories/goals_repository.dart';

class DeleteGoal {
  final GoalsRepository repository;

  const DeleteGoal(this.repository);

  Future<void> call({required String goalId}) {
    return repository.deleteGoal(goalId: goalId);
  }
}
