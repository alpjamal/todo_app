import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosLoading()) {
    on<LoadTodos>(_loadTodos);
    on<AddTodo>(_addTodo);
    on<TodoDone>(_updateTodo);
    on<DeleteTodo>(_deleteTodo);
  }

  _loadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(Duration(seconds: 1));
    emit(TodosLoaded(todos: event.todos));
  }

  _addTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      emit(TodosLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  _deleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) => todo.id != event.todo.id).toList();
      emit(TodosLoaded(todos: todos));
    }
  }

  _updateTodo(TodoDone event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      emit(TodosLoaded(todos: todos));
    }
  }
}
