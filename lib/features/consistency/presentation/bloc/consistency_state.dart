import 'package:equatable/equatable.dart';

import '../../domain/entities/consistency.dart';
import '../../domain/entities/user_weight.dart';

abstract class ConsistencyState extends Equatable {
  const ConsistencyState();

  @override
  List<Object?> get props => [];
}

class ConsistencyInitial extends ConsistencyState {
  const ConsistencyInitial();
}

class ConsistencyLoading extends ConsistencyState {
  const ConsistencyLoading();
}

class ConsistencyLoaded extends ConsistencyState {
  final Consistency consistency;
  final List<UserWeight> weights;

  const ConsistencyLoaded({required this.consistency, required this.weights});

  @override
  List<Object?> get props => [consistency, weights];
}

class ConsistencyActionLoading extends ConsistencyState {
  final Consistency consistency;
  final List<UserWeight> weights;

  const ConsistencyActionLoading({
    required this.consistency,
    required this.weights,
  });

  @override
  List<Object?> get props => [consistency, weights];
}

class ConsistencyFailure extends ConsistencyState {
  final String message;

  const ConsistencyFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
