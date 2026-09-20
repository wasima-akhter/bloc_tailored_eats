import 'package:equatable/equatable.dart';

class Consistency extends Equatable {
  final int currentStreak;
  final int longestStreak;
  final int totalDays;
  final int completedDays;
  final int weeklyPercentage;
  final int monthlyPercentage;

  const Consistency({
    required this.currentStreak,
    required this.longestStreak,
    required this.totalDays,
    required this.completedDays,
    required this.weeklyPercentage,
    required this.monthlyPercentage,
  });

  @override
  List<Object?> get props => [
    currentStreak,
    longestStreak,
    totalDays,
    completedDays,
    weeklyPercentage,
    monthlyPercentage,
  ];
}
