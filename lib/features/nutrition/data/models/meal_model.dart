import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.calories,
    required super.protein,
    required super.carbs,
    required super.fat,
    required super.isAte,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: JsonParser.string(json['_id'] ?? json['id']),
      name: JsonParser.string(json['name'] ?? json['mealName']),
      image: JsonParser.string(json['image'] ?? json['imageUrl']),
      description: JsonParser.string(json['description']),
      calories: JsonParser.integer(json['calories']),
      protein: JsonParser.decimal(json['protein']),
      carbs: JsonParser.decimal(json['carbs'] ?? json['carbohydrates']),
      fat: JsonParser.decimal(json['fat']),
      isAte: JsonParser.boolean(json['isAte'] ?? json['ate']),
    );
  }
}
