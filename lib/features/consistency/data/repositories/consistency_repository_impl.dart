import '../../domain/entities/consistency.dart';
import '../../domain/entities/user_weight.dart';
import '../../domain/repositories/consistency_repository.dart';
import '../datasources/consistency_remote_datasource.dart';

class ConsistencyRepositoryImpl implements ConsistencyRepository {
  final ConsistencyRemoteDataSource remoteDataSource;

  const ConsistencyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Consistency> getUserConsistency() {
    return remoteDataSource.getUserConsistency();
  }

  @override
  Future<UserWeight> addUserWeight({required double weight}) {
    return remoteDataSource.addUserWeight(weight: weight);
  }

  @override
  Future<List<UserWeight>> getUserWeight() {
    return remoteDataSource.getUserWeight();
  }
}
