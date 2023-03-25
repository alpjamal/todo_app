// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit() : super(TasksLoading());

  List<Task> _tasks = [
    ...List.generate(
      10,
      (index) => Task(
        id: DateTime.now().toString(),
        title: 'PlaceHolder',
        time: TimeOfDay.now(),
        category: TaskCategory.shopping,
      ),
    ),
  ];

  int get tasksLength => _tasks.length;

  loadTasks() async {
    await Future.delayed(Duration(seconds: 1));
    emit(TasksLoaded(_tasks));
  }
}
