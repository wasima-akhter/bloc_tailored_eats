import '../entities/meal.dart';

abstract class NutritionRepository {
  Future<List<Meal>> getCustomMeals();

  Future<void> markMealAsAte({required String mealId});

  Future<Meal> swapMeal({required String mealId});
}
