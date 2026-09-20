import '../entities/consistency.dart';
import '../repositories/consistency_repository.dart';

class GetUserConsistency {
  final ConsistencyRepository repository;

  const GetUserConsistency(this.repository);

  Future<Consistency> call() {
    return repository.getUserConsistency();
  }
}
