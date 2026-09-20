import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/user_weight.dart';

class UserWeightModel extends UserWeight {
  const UserWeightModel({
    required super.id,
    required super.weight,
    required super.date,
  });

  factory UserWeightModel.fromJson(Map<String, dynamic> json) {
    return UserWeightModel(
      id: JsonParser.string(json['_id'] ?? json['id']),
      weight: JsonParser.decimal(json['weight']),
      date: JsonParser.string(json['date'] ?? json['createdAt']),
    );
  }
}
