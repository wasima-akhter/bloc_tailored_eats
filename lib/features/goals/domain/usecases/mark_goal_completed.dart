import '../repositories/goals_repository.dart';

class MarkGoalCompleted {
  final GoalsRepository repository;

  const MarkGoalCompleted(this.repository);

  Future<void> call({required String goalId}) {
    return repository.markGoalCompleted(goalId: goalId);
  }
}
