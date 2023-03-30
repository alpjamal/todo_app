import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/models/todo_category/todo_category.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends Equatable {

  @HiveField(0)
  final String? id;
  
  @HiveField(1)
  final String title;
  
  @HiveField(2)
  final DateTime dayTime;
  
  @HiveField(3)
  final TodoCategory category;
  
  @HiveField(4)
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
    DateTime? dayTime,
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
