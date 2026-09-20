import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String image;
  final String description;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final bool isAte;

  const Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.isAte,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    description,
    calories,
    protein,
    carbs,
    fat,
    isAte,
  ];
}
