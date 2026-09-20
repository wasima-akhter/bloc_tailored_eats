import 'package:equatable/equatable.dart';

class HomeData extends Equatable {
  final String userName;
  final String profileImage;
  final int totalCalories;
  final int consumedCalories;
  final int remainingCalories;
  final int waterIntake;
  final int waterGoal;
  final int completedGoals;
  final int totalGoals;

  const HomeData({
    required this.userName,
    required this.profileImage,
    required this.totalCalories,
    required this.consumedCalories,
    required this.remainingCalories,
    required this.waterIntake,
    required this.waterGoal,
    required this.completedGoals,
    required this.totalGoals,
  });

  @override
  List<Object?> get props => [
    userName,
    profileImage,
    totalCalories,
    consumedCalories,
    remainingCalories,
    waterIntake,
    waterGoal,
    completedGoals,
    totalGoals,
  ];
}
