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
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Todo? get alertTodo {
    Todo? alertTodo;
    if (_todos.isNotEmpty) {
      try {
        alertTodo = _todos.firstWhere((todo) => todo.dayTime.difference(DateTime.now()).inDays == 0);
      } catch (e) {
        alertTodo = null;
      }
    }

    return alertTodo;
  }

  _loadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    await Future.delayed(Duration(seconds: 1));
    _todos = event.todos;
    emit(TodosLoaded(todos: event.todos));
  }

  _addTodo(AddTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      _todos = List.from(state.todos)..add(event.todo);
      emit(TodosLoaded(todos: List.from(state.todos)..add(event.todo)));
    }
  }

  _deleteTodo(DeleteTodo event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.where((todo) => todo.id != event.todo.id).toList();
      _todos = todos;
      emit(TodosLoaded(todos: todos));
    }
  }

  _updateTodo(TodoDone event, Emitter<TodosState> emit) {
    final state = this.state;
    if (state is TodosLoaded) {
      List<Todo> todos = state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      _todos = todos;
      emit(TodosLoaded(todos: todos));
    }
  }
}
