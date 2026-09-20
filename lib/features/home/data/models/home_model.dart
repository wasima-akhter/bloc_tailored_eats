import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/home_data.dart';

class HomeModel extends HomeData {
  const HomeModel({
    required super.userName,
    required super.profileImage,
    required super.totalCalories,
    required super.consumedCalories,
    required super.remainingCalories,
    required super.waterIntake,
    required super.waterGoal,
    required super.completedGoals,
    required super.totalGoals,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      userName: JsonParser.string(json['userName'] ?? json['name']),
      profileImage: JsonParser.string(
        json['profileImage'] ?? json['profile_image'],
      ),
      totalCalories: JsonParser.integer(json['totalCalories']),
      consumedCalories: JsonParser.integer(json['consumedCalories']),
      remainingCalories: JsonParser.integer(json['remainingCalories']),
      waterIntake: JsonParser.integer(json['waterIntake']),
      waterGoal: JsonParser.integer(json['waterGoal']),
      completedGoals: JsonParser.integer(json['completedGoals']),
      totalGoals: JsonParser.integer(json['totalGoals']),
    );
  }
}
