import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/add_user_weight.dart';
import '../../domain/entities/get_user_consistency.dart';
import '../../domain/entities/get_user_weight.dart';
import '../../domain/entities/user_weight.dart';
import 'consistency_state.dart';

class ConsistencyCubit extends Cubit<ConsistencyState> {
  final GetUserConsistency getUserConsistency;
  final AddUserWeight addUserWeight;
  final GetUserWeight getUserWeight;

  ConsistencyCubit({
    required this.getUserConsistency,
    required this.addUserWeight,
    required this.getUserWeight,
  }) : super(const ConsistencyInitial());

  Future<void> loadConsistency() async {
    emit(const ConsistencyLoading());

    try {
      final results = await Future.wait([
        getUserConsistency(),
        getUserWeight(),
      ]);

      emit(
        ConsistencyLoaded(
          consistency: results[0] as dynamic,
          weights: results[1] as List<UserWeight>,
        ),
      );
    } catch (e) {
      emit(ConsistencyFailure(message: e.toString()));
    }
  }

  Future<void> saveWeight({required double weight}) async {
    final currentState = state;

    if (currentState is! ConsistencyLoaded) {
      return;
    }

    emit(
      ConsistencyActionLoading(
        consistency: currentState.consistency,
        weights: currentState.weights,
      ),
    );

    try {
      await addUserWeight(weight: weight);

      await loadConsistency();
    } catch (e) {
      emit(ConsistencyFailure(message: e.toString()));
    }
  }
}
