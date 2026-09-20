import 'package:equatable/equatable.dart';

import '../../domain/entities/goal.dart';

abstract class GoalsState extends Equatable {
  const GoalsState();

  @override
  List<Object?> get props => [];
}

class GoalsInitial extends GoalsState {
  const GoalsInitial();
}

class GoalsLoading extends GoalsState {
  const GoalsLoading();
}

class GoalsLoaded extends GoalsState {
  final List<Goal> goals;
  final double completedPercentage;

  const GoalsLoaded({required this.goals, required this.completedPercentage});

  @override
  List<Object?> get props => [goals, completedPercentage];
}

class GoalsActionLoading extends GoalsState {
  final List<Goal> goals;
  final double completedPercentage;

  const GoalsActionLoading({
    required this.goals,
    required this.completedPercentage,
  });

  @override
  List<Object?> get props => [goals, completedPercentage];
}

class GoalsFailure extends GoalsState {
  final String message;

  const GoalsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
