import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/app_loader.dart';
import '../bloc/nutrition_cubit.dart';
import '../bloc/nutrition_state.dart';

class NutritionPage extends StatelessWidget {
  const NutritionPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NutritionCubit>()..loadMeals(),
      child: const _NutritionView(),
    );
  }
}

class _NutritionView extends StatelessWidget {
  const _NutritionView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition'),
      ),
      body: BlocBuilder<NutritionCubit, NutritionState>(
        builder: (context, state) {
          if (state is NutritionLoading) {
            return const AppLoader();
          }

          if (state is NutritionFailure) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () {
                context
                    .read<NutritionCubit>()
                    .loadMeals();
              },
            );
          }

          if (state is NutritionLoaded ||
              state is MealActionLoading) {
            final meals = state is NutritionLoaded
                ? state.meals
                : (state as MealActionLoading).meals;

            if (meals.isEmpty) {
              return const Center(
                child: Text('No meals found.'),
              );
            }

            final isActionLoading =
                state is MealActionLoading;

            return RefreshIndicator(
              onRefresh: () {
                return context
                    .read<NutritionCubit>()
                    .loadMeals();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: meals.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final meal = meals[index];

                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            meal.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (meal.description.isNotEmpty) ...[
                            const SizedBox(height: 6),
                            Text(meal.description),
                          ],
                          const SizedBox(height: 12),
                          Text(
                            'Calories: ${meal.calories}',
                          ),
                          Text(
                            'Protein: ${meal.protein}g',
                          ),
                          Text(
                            'Carbs: ${meal.carbs}g',
                          ),
                          Text(
                            'Fat: ${meal.fat}g',
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed:
                                      isActionLoading
                                          ? null
                                          : () {
                                              context
                                                  .read<
                                                      NutritionCubit>()
                                                  .swapMealItem(
                                                    mealId:
                                                        meal.id,
                                                  );
                                            },
                                  child:
                                      const Text('Swap'),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed:
                                      isActionLoading ||
                                              meal.isAte
                                          ? null
                                          : () {
                                              context
                                                  .read<
                                                      NutritionCubit>()
                                                  .ateMeal(
                                                    mealId:
                                                        meal.id,
                                                  );
                                            },
                                  child: Text(
                                    meal.isAte
                                        ? 'Ate'
                                        : 'Mark Ate',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
