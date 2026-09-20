import '../../domain/entities/meal.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../datasources/nutrition_remote_datasource.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  final NutritionRemoteDataSource remoteDataSource;

  const NutritionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Meal>> getCustomMeals() {
    return remoteDataSource.getCustomMeals();
  }

  @override
  Future<void> markMealAsAte({required String mealId}) {
    return remoteDataSource.markMealAsAte(mealId: mealId);
  }

  @override
  Future<Meal> swapMeal({required String mealId}) {
    return remoteDataSource.swapMeal(mealId: mealId);
  }
}
