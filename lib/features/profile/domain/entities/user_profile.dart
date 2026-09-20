import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final int age;
  final double height;
  final double weight;
  final String activityLevel;
  final String foodVibe;
  final String mainGoal;
  final String result;
  final String training;
  final String image;
  final String profileImage;
  final double calorie;
  final String subscriptionPlan;
  final bool isTwoFactor;

  const Profile({
    required this.id,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.age,
    required this.height,
    required this.weight,
    required this.activityLevel,
    required this.foodVibe,
    required this.mainGoal,
    required this.result,
    required this.training,
    required this.image,
    required this.profileImage,
    required this.calorie,
    required this.subscriptionPlan,
    required this.isTwoFactor,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    firstName,
    lastName,
    email,
    gender,
    age,
    height,
    weight,
    activityLevel,
    foodVibe,
    mainGoal,
    result,
    training,
    image,
    profileImage,
    calorie,
    subscriptionPlan,
    isTwoFactor,
  ];
}
