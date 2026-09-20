import 'package:equatable/equatable.dart';

import '../../domain/entities/meal.dart';

abstract class NutritionState extends Equatable {
  const NutritionState();

  @override
  List<Object?> get props => [];
}

class NutritionInitial extends NutritionState {
  const NutritionInitial();
}

class NutritionLoading extends NutritionState {
  const NutritionLoading();
}

class NutritionLoaded extends NutritionState {
  final List<Meal> meals;

  const NutritionLoaded({required this.meals});

  @override
  List<Object?> get props => [meals];
}

class NutritionFailure extends NutritionState {
  final String message;

  const NutritionFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class MealActionLoading extends NutritionState {
  final List<Meal> meals;

  const MealActionLoading({required this.meals});

  @override
  List<Object?> get props => [meals];
}
