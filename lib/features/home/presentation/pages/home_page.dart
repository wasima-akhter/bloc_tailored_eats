import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../bloc/home_cubit.dart';
import '../bloc/home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..loadHome(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const AppLoader();
          }

          if (state is HomeFailure) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context.read<HomeCubit>().loadHome();
              },
            );
          }

          if (state is HomeLoaded) {
            final data = state.data;

            return RefreshIndicator(
              onRefresh: () {
                return context.read<HomeCubit>().loadHome();
              },
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Text(
                    'Hello, ${data.userName}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _InfoCard(
                    title: 'Calories',
                    value: '${data.consumedCalories} / ${data.totalCalories}',
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    title: 'Remaining Calories',
                    value: '${data.remainingCalories}',
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    title: 'Water',
                    value: '${data.waterIntake} / ${data.waterGoal}',
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    title: 'Goals',
                    value: '${data.completedGoals} / ${data.totalGoals}',
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
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.value});

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
