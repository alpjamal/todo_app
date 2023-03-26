import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/todo_category.dart';

class Todo extends Equatable {
  final String? id;
  final String title;
  final String dayTime;
  final TodoCategory category;
  final bool isCompleted;

  Todo({
    required this.id,
    required this.title,
    required this.dayTime,
    required this.category,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, title, dayTime, category, isCompleted];

  Todo copyWith({
    String? id,
    String? title,
    String? dayTime,
    TodoCategory? category,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      dayTime: dayTime ?? this.dayTime,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
