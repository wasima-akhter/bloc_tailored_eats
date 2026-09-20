import '../entities/meal.dart';
import '../repositories/nutrition_repository.dart';

class GetCustomMeals {
  final NutritionRepository repository;

  const GetCustomMeals(this.repository);

  Future<List<Meal>> call() {
    return repository.getCustomMeals();
  }
}
