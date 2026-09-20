import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class SwapMeal {
  final NutritionRepository repository;

  const SwapMeal(this.repository);

  Future<Meal> call({required String mealId}) {
    return repository.swapMeal(mealId: mealId);
  }
}
