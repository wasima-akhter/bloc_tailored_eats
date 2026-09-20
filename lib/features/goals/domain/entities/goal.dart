import 'package:equatable/equatable.dart';

class Goal extends Equatable {
  final String id;
  final String title;
  final String description;
  final String type;
  final bool isCompleted;
  final String dueDate;
  final int progress;

  const Goal({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.isCompleted,
    required this.dueDate,
    required this.progress,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    type,
    isCompleted,
    dueDate,
    progress,
  ];
}
