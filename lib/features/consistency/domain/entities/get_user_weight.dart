import '../entities/user_weight.dart';
import '../repositories/consistency_repository.dart';

class GetUserWeight {
  final ConsistencyRepository repository;

  const GetUserWeight(this.repository);

  Future<List<UserWeight>> call() {
    return repository.getUserWeight();
  }
}
