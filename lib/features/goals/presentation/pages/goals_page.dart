import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../domain/entities/goal.dart';
import '../bloc/goals_cubit.dart';
import '../bloc/goals_state.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GoalsCubit>()..loadGoals(),
      child: const _GoalsView(),
    );
  }
}

class _GoalsView extends StatelessWidget {
  const _GoalsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Goals')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateGoalDialog(context);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<GoalsCubit, GoalsState>(
        builder: (context, state) {
          if (state is GoalsLoading) {
            return const AppLoader();
          }

          if (state is GoalsFailure) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<GoalsCubit>().loadGoals();
              },
            );
          }

          if (state is GoalsLoaded || state is GoalsActionLoading) {
            final goals = state is GoalsLoaded
                ? state.goals
                : (state as GoalsActionLoading).goals;

            final percentage = state is GoalsLoaded
                ? state.completedPercentage
                : (state as GoalsActionLoading).completedPercentage;

            final isLoading = state is GoalsActionLoading;

            return RefreshIndicator(
              onRefresh: () {
                return context.read<GoalsCubit>().loadGoals();
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Completed: ${percentage.toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  LinearProgressIndicator(
                    value: (percentage / 100).clamp(0.0, 1.0),
                  ),
                  const SizedBox(height: 24),
                  if (goals.isEmpty)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text('No goals found.'),
                      ),
                    )
                  else
                    ...goals.map(
                      (goal) => _GoalCard(
                        goal: goal,
                        isLoading: isLoading,
                        onComplete: () {
                          context.read<GoalsCubit>().completeGoal(
                            goalId: goal.id,
                          );
                        },
                        onDelete: () {
                          context.read<GoalsCubit>().removeGoal(
                            goalId: goal.id,
                          );
                        },
                      ),
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showCreateGoalDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final typeController = TextEditingController();
    final dueDateController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Create Goal'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: typeController,
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
                TextField(
                  controller: dueDateController,
                  decoration: const InputDecoration(labelText: 'Due Date'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.trim().isEmpty) {
                  return;
                }

                Navigator.pop(dialogContext);

                context.read<GoalsCubit>().createNewGoal(
                  title: titleController.text.trim(),
                  description: descriptionController.text.trim(),
                  type: typeController.text.trim(),
                  dueDate: dueDateController.text.trim(),
                );
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    ).then((_) {
      titleController.dispose();
      descriptionController.dispose();
      typeController.dispose();
      dueDateController.dispose();
    });
  }
}

class _GoalCard extends StatelessWidget {
  const _GoalCard({
    required this.goal,
    required this.isLoading,
    required this.onComplete,
    required this.onDelete,
  });

  final Goal goal;
  final bool isLoading;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    goal.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (goal.isCompleted)
                  const Icon(Icons.check_circle, color: Colors.green),
              ],
            ),
            if (goal.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(goal.description),
            ],
            const SizedBox(height: 8),
            Text('Type: ${goal.type}'),
            if (goal.dueDate.isNotEmpty) Text('Due: ${goal.dueDate}'),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: (goal.progress / 100).clamp(0.0, 1.0),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: isLoading || goal.isCompleted
                        ? null
                        : onComplete,
                    child: Text(goal.isCompleted ? 'Completed' : 'Complete'),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: isLoading ? null : onDelete,
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*


YOU
 │
 │ context.read<GoalsCubit>().getAllGoals()
 ↓
GoalsCubit
 │
 │ _getAllGoals()
 ↓
GetAllGoals
 │
 │ repository.getAllGoals()
 ↓
GoalsRepository
 │
 │ ACTUAL OBJECT:
 │ └── GoalsRepositoryImpl
 ↓
GoalsRepositoryImpl
 │
 │ remoteDataSource.getAllGoals()
 ↓
GoalsRemoteDataSource
 │
 │ ACTUAL OBJECT:
 │ └── GoalsRemoteDataSourceImpl
 ↓
GoalsRemoteDataSourceImpl
 │
 │ apiClient.dio.get(...)
 ↓
Dio
 │
 ↓
BACKEND

*/
