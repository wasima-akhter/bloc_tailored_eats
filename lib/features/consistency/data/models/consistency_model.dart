import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/consistency.dart';

class ConsistencyModel extends Consistency {
  const ConsistencyModel({
    required super.currentStreak,
    required super.longestStreak,
    required super.totalDays,
    required super.completedDays,
    required super.weeklyPercentage,
    required super.monthlyPercentage,
  });

  factory ConsistencyModel.fromJson(Map<String, dynamic> json) {
    return ConsistencyModel(
      currentStreak: JsonParser.integer(json['currentStreak']),
      longestStreak: JsonParser.integer(json['longestStreak']),
      totalDays: JsonParser.integer(json['totalDays']),
      completedDays: JsonParser.integer(json['completedDays']),
      weeklyPercentage: JsonParser.integer(json['weeklyPercentage']),
      monthlyPercentage: JsonParser.integer(json['monthlyPercentage']),
    );
  }
}
