import '../../../../core/utils/json_parser.dart';
import '../../domain/entities/goal.dart';

class GoalModel extends Goal {
  const GoalModel({
    required super.id,
    required super.title,
    required super.description,
    required super.type,
    required super.isCompleted,
    required super.dueDate,
    required super.progress,
  });

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: JsonParser.string(json['_id'] ?? json['id'], field: '_id'),
      title: JsonParser.string(json['title'] ?? json['name'], field: 'title'),
      description: JsonParser.string(json['description'], field: 'description'),
      type: JsonParser.string(json['type'] ?? json['goalType'], field: 'type'),
      isCompleted: JsonParser.boolean(
        json['isCompleted'] ?? json['completed'],
        field: 'isCompleted',
      ),
      dueDate: JsonParser.string(
        json['dueDate'] ?? json['deadline'],
        field: 'dueDate',
      ),
      progress: JsonParser.integer(json['progress'], field: 'progress'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'type': type,
      'isCompleted': isCompleted,
      'dueDate': dueDate,
      'progress': progress,
    };
  }
}
