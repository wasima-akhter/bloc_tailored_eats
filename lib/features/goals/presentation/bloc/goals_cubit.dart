import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/goal.dart';
import '../../domain/usecases/change_goal_type.dart';
import '../../domain/usecases/create_goal.dart';
import '../../domain/usecases/delete_goal.dart';
import '../../domain/usecases/get_all_goals.dart';
import '../../domain/usecases/get_completed_goal_percentage.dart';
import '../../domain/usecases/mark_goal_completed.dart';
import '../../domain/usecases/update_goal.dart';
import 'goals_state.dart';

class GoalsCubit extends Cubit<GoalsState> {
  final CreateGoal createGoal;
  final GetAllGoals getAllGoals;
  final MarkGoalCompleted markGoalCompleted;
  final UpdateGoal updateGoal;
  final DeleteGoal deleteGoal;
  final ChangeGoalType changeGoalType;
  final GetCompletedGoalPercentage getCompletedGoalPercentage;

  GoalsCubit({
    required this.createGoal,
    required this.getAllGoals,
    required this.markGoalCompleted,
    required this.updateGoal,
    required this.deleteGoal,
    required this.changeGoalType,
    required this.getCompletedGoalPercentage,
  }) : super(const GoalsInitial());

  Future<void> loadGoals() async {
    emit(const GoalsLoading());

    try {
      final results = await Future.wait([
        getAllGoals(),
        getCompletedGoalPercentage(),
      ]);

      emit(
        GoalsLoaded(
          goals: results[0] as List<Goal>,
          completedPercentage: results[1] as double,
        ),
      );
    } catch (e) {
      emit(GoalsFailure(message: e.toString()));
    }
  }

  Future<void> createNewGoal({
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) async {
    await _performAction(() async {
      await createGoal(
        title: title,
        description: description,
        type: type,
        dueDate: dueDate,
      );
    });
  }

  Future<void> completeGoal({required String goalId}) async {
    await _performAction(() async {
      await markGoalCompleted(goalId: goalId);
    });
  }

  Future<void> updateExistingGoal({
    required String goalId,
    required String title,
    required String description,
    required String type,
    required String dueDate,
  }) async {
    await _performAction(() async {
      await updateGoal(
        goalId: goalId,
        title: title,
        description: description,
        type: type,
        dueDate: dueDate,
      );
    });
  }

  Future<void> removeGoal({required String goalId}) async {
    await _performAction(() async {
      await deleteGoal(goalId: goalId);
    });
  }

  Future<void> updateGoalType({
    required String goalId,
    required String type,
  }) async {
    await _performAction(() async {
      await changeGoalType(goalId: goalId, type: type);
    });
  }

  Future<void> _performAction(Future<void> Function() action) async {
    final currentState = state;

    if (currentState is! GoalsLoaded) {
      return;
    }

    emit(
      GoalsActionLoading(
        goals: currentState.goals,
        completedPercentage: currentState.completedPercentage,
      ),
    );

    try {
      await action();
      await loadGoals();
    } catch (e) {
      emit(GoalsFailure(message: e.toString()));
    }
  }
}
