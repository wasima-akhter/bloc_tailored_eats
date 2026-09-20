import '../entities/user_weight.dart';
import '../repositories/consistency_repository.dart';

class AddUserWeight {
  final ConsistencyRepository repository;

  const AddUserWeight(this.repository);

  Future<UserWeight> call({required double weight}) {
    return repository.addUserWeight(weight: weight);
  }
}
