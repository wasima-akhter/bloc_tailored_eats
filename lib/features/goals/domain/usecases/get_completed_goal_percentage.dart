import '../repositories/goals_repository.dart';

class GetCompletedGoalPercentage {
  final GoalsRepository repository;

  const GetCompletedGoalPercentage(this.repository);

  Future<double> call() {
    return repository.getCompletedGoalPercentage();
  }
}
