// lib/features/goals/data/datasources/goals_local_datasource_impl.dart

import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../models/goal_model.dart';
import 'goals_local_datasource.dart';

class GoalsLocalDataSourceImpl implements GoalsLocalDataSource {
  final AppDatabase database;

  const GoalsLocalDataSourceImpl({required this.database});

  @override
  Future<List<GoalModel>> getAllGoals() async {
    final rows = await database.select(database.goalsTable).get();

    return rows
        .map(
          (row) => GoalModel(
            id: row.id,
            title: row.title,
            description: row.description,
            type: row.type,
            isCompleted: row.isCompleted,
            dueDate: row.dueDate,
            progress: row.progress,
          ),
        )
        .toList();
  }

  @override
  Future<void> saveGoals(List<GoalModel> goals) async {
    await database.transaction(() async {
      await database.batch((batch) {
        batch.insertAllOnConflictUpdate(
          database.goalsTable,
          goals.map(
            (goal) => GoalsTableCompanion.insert(
              id: goal.id,
              title: Value(goal.title),
              description: Value(goal.description),
              type: Value(goal.type),
              isCompleted: Value(goal.isCompleted),
              dueDate: Value(goal.dueDate),
              progress: Value(goal.progress),
            ),
          ),
        );
      });
    });
  }

  @override
  Future<void> saveGoal(GoalModel goal) async {
    await database
        .into(database.goalsTable)
        .insertOnConflictUpdate(
          GoalsTableCompanion.insert(
            id: goal.id,
            title: Value(goal.title),
            description: Value(goal.description),
            type: Value(goal.type),
            isCompleted: Value(goal.isCompleted),
            dueDate: Value(goal.dueDate),
            progress: Value(goal.progress),
          ),
        );
  }

  @override
  Future<void> deleteGoal(String goalId) async {
    await (database.delete(
      database.goalsTable,
    )..where((table) => table.id.equals(goalId))).go();
  }

  @override
  Future<void> clearGoals() async {
    await database.delete(database.goalsTable).go();
  }
}
