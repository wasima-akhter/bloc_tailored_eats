import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_custom_meals.dart';
import '../../domain/usecases/mark_meal_as_ate.dart';
import '../../domain/usecases/swap_meal.dart';
import 'nutrition_state.dart';

class NutritionCubit extends Cubit<NutritionState> {
  final GetCustomMeals getCustomMeals;
  final MarkMealAsAte markMealAsAte;
  final SwapMeal swapMeal;

  NutritionCubit({
    required this.getCustomMeals,
    required this.markMealAsAte,
    required this.swapMeal,
  }) : super(const NutritionInitial());

  Future<void> loadMeals() async {
    emit(const NutritionLoading());

    try {
      final meals = await getCustomMeals();

      emit(
        NutritionLoaded(
          meals: meals,
        ),
      );
    } catch (e) {
      emit(
        NutritionFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> ateMeal({
    required String mealId,
  }) async {
    final currentState = state;

    if (currentState is! NutritionLoaded) {
      return;
    }

    emit(
      MealActionLoading(
        meals: currentState.meals,
      ),
    );

    try {
      await markMealAsAte(
        mealId: mealId,
      );

      await loadMeals();
    } catch (e) {
      emit(
        NutritionFailure(
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> swapMealItem({
    required String mealId,
  }) async {
    final currentState = state;

    if (currentState is! NutritionLoaded) {
      return;
    }

    emit(
      MealActionLoading(
        meals: currentState.meals,
      ),
    );

    try {
      final swappedMeal = await swapMeal(
        mealId: mealId,
      );

      final updatedMeals = currentState.meals
          .map(
            (meal) =>
                meal.id == mealId ? swappedMeal : meal,
          )
          .toList();

      emit(
        NutritionLoaded(
          meals: updatedMeals,
        ),
      );
    } catch (e) {
      emit(
        NutritionFailure(
          message: e.toString(),
        ),
      );
    }
  }
}
