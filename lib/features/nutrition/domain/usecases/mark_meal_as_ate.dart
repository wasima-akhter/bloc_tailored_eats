import '../repositories/nutrition_repository.dart';

class MarkMealAsAte {
  final NutritionRepository repository;

  const MarkMealAsAte(this.repository);

  Future<void> call({required String mealId}) {
    return repository.markMealAsAte(mealId: mealId);
  }
}
