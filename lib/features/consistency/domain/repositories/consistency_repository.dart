import '../entities/consistency.dart';
import '../entities/user_weight.dart';

abstract class ConsistencyRepository {
  Future<Consistency> getUserConsistency();

  Future<UserWeight> addUserWeight({required double weight});

  Future<List<UserWeight>> getUserWeight();
}
