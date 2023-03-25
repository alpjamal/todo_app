part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {}

class TasksLoading extends TasksState {
  @override
  List<Object?> get props => [];
}

class TasksLoaded extends TasksState {
  final List<Task> tasks;
  TasksLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}
