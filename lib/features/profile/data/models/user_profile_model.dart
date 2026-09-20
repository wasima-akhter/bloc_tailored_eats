import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/user_profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.gender,
    required super.age,
    required super.height,
    required super.weight,
    required super.activityLevel,
    required super.foodVibe,
    required super.mainGoal,
    required super.result,
    required super.training,
    required super.image,
    required super.profileImage,
    required super.calorie,
    required super.subscriptionPlan,
    required super.isTwoFactor,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: JsonParser.string(json['_id'] ?? json['id']),
      name: JsonParser.string(json['name']),
      firstName: JsonParser.string(json['firstName']),
      lastName: JsonParser.string(json['lastName']),
      email: JsonParser.string(json['email']),
      gender: JsonParser.string(json['gender']),
      age: JsonParser.integer(json['age']),
      height: JsonParser.decimal(json['height']),
      weight: JsonParser.decimal(json['weight']),
      activityLevel: JsonParser.string(json['activityLevel']),
      foodVibe: JsonParser.string(json['foodVibe']),
      mainGoal: JsonParser.string(json['mainGoal']),
      result: JsonParser.string(json['result']),
      training: JsonParser.string(json['training']),
      image: JsonParser.string(json['image']),
      profileImage: JsonParser.string(json['profile_image']),
      calorie: JsonParser.decimal(json['calorie']),
      subscriptionPlan: JsonParser.string(json['subscriptionPlan']),
      isTwoFactor: JsonParser.boolean(json['isTwoFactor']),
    );
  }
}
