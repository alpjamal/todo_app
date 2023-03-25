import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TaskCategory { personal, work, meeting, shopping, party, study }

class Task extends Equatable {
  final String id;
  final String title;
  final TimeOfDay time;
  final TaskCategory category;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.time,
    required this.category,
    this.isCompleted = false,
  });
  
  @override
  List<Object?> get props => [id, title, time, category, isCompleted];

  Task copyWith(
    String? id,
    String? title,
    TimeOfDay? time,
    TaskCategory? category,
    bool? isCompleted,
  ) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
