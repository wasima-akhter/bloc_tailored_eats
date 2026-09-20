import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../bloc/consistency_cubit.dart';
import '../bloc/consistency_state.dart';

class ConsistencyPage extends StatelessWidget {
  const ConsistencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ConsistencyCubit>()..loadConsistency(),
      child: const _ConsistencyView(),
    );
  }
}

class _ConsistencyView extends StatelessWidget {
  const _ConsistencyView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress')),
      body: BlocBuilder<ConsistencyCubit, ConsistencyState>(
        builder: (context, state) {
          if (state is ConsistencyLoading) {
            return const AppLoader();
          }

          if (state is ConsistencyFailure) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<ConsistencyCubit>().loadConsistency();
              },
            );
          }

          if (state is ConsistencyLoaded || state is ConsistencyActionLoading) {
            final consistency = state is ConsistencyLoaded
                ? state.consistency
                : (state as ConsistencyActionLoading).consistency;

            final weights = state is ConsistencyLoaded
                ? state.weights
                : (state as ConsistencyActionLoading).weights;

            final isLoading = state is ConsistencyActionLoading;

            return RefreshIndicator(
              onRefresh: () {
                return context.read<ConsistencyCubit>().loadConsistency();
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _StatCard(
                    title: 'Current Streak',
                    value: '${consistency.currentStreak} days',
                  ),
                  const SizedBox(height: 12),
                  _StatCard(
                    title: 'Longest Streak',
                    value: '${consistency.longestStreak} days',
                  ),
                  const SizedBox(height: 12),
                  _StatCard(
                    title: 'Completed Days',
                    value:
                        '${consistency.completedDays} / ${consistency.totalDays}',
                  ),
                  const SizedBox(height: 12),
                  _StatCard(
                    title: 'Weekly Progress',
                    value: '${consistency.weeklyPercentage}%',
                  ),
                  const SizedBox(height: 12),
                  _StatCard(
                    title: 'Monthly Progress',
                    value: '${consistency.monthlyPercentage}%',
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Weight History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  if (weights.isEmpty)
                    const Text('No weight records found.')
                  else
                    ...weights.map((weight) => _WeightTile(weight: weight)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            _showAddWeightDialog(context);
                          },
                    child: const Text('Add Weight'),
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

  void _showAddWeightDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Add Weight'),
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Weight',
              hintText: 'Enter weight',
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
                final weight = double.tryParse(controller.text.trim());

                if (weight == null || weight <= 0) {
                  return;
                }

                Navigator.pop(dialogContext);

                context.read<ConsistencyCubit>().saveWeight(weight: weight);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    ).then((_) {
      controller.dispose();
    });
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _WeightTile extends StatelessWidget {
  const _WeightTile({required this.weight});

  final dynamic weight;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text('${weight.weight}'),
      subtitle: Text(weight.date),
    );
  }
}
