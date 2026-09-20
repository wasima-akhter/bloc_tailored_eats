import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/meal_model.dart';

abstract class NutritionRemoteDataSource {
  Future<List<MealModel>> getCustomMeals();

  Future<void> markMealAsAte({required String mealId});

  Future<MealModel> swapMeal({required String mealId});
}

class NutritionRemoteDataSourceImpl implements NutritionRemoteDataSource {
  final ApiClient apiClient;

  const NutritionRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MealModel>> getCustomMeals() async {
    final response = await apiClient.dio.get(ApiEndpoints.getCustomMeal);

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'];

    if (data is List) {
      return data
          .whereType<Map<String, dynamic>>()
          .map(MealModel.fromJson)
          .toList();
    }

    if (data is Map<String, dynamic>) {
      final meals = data['meals'];

      if (meals is List) {
        return meals
            .whereType<Map<String, dynamic>>()
            .map(MealModel.fromJson)
            .toList();
      }
    }

    return [];
  }

  @override
  Future<void> markMealAsAte({required String mealId}) async {
    await apiClient.dio.patch(ApiEndpoints.ateMeal, data: {'mealId': mealId});
  }

  @override
  Future<MealModel> swapMeal({required String mealId}) async {
    final response = await apiClient.dio.get(
      ApiEndpoints.swapMeal,
      queryParameters: {'mealId': mealId},
    );

    final responseData = response.data as Map<String, dynamic>;

    final data = responseData['data'] as Map<String, dynamic>? ?? {};

    return MealModel.fromJson(data);
  }
}
