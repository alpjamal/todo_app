import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/constants.dart';

import '../../models/todo/todo.dart';

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
  List<Todo> get todos => sortTodos();

  List<Todo> sortTodos() {
    _todos.sort((a, b) => a.dayTime.compareTo(b.dayTime));
    return _todos;
  }

  separate(todos) {
    Map<String, List<Todo>> map = {};
    for (var i = 0; i < todos.length; i++) {
      String day = DateFormat('dd MM yyy').format(todos[i].dayTime);
      Todo todo = todos[i];
      map[day] == null ? map[day] = [] : null;
      map[day]!.add(todo);
    }

    map = map.map((key, value) {
      bool isToday = DateFormat('dd MM yyy').format(DateTime.now()) == key;
      bool isTomorrow = DateFormat('dd MM yyy').format(DateTime.now().add(Duration(days: 1))) == key;
      return MapEntry(isToday ? 'Today' : isTomorrow ? 'Tomorrow' : key, value);
    });
    
    return map;
  }

  Todo? get alertTodo {
    Todo? alertTodo;
    if (todos.isNotEmpty) {
      try {
        alertTodo = todos.firstWhere((todo) => todo.dayTime.difference(DateTime.now()).inHours < 5);
      } catch (e) {
        alertTodo = null;
      }
    }
    return alertTodo;
  }

  _loadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    Box<Todo> todosBox = await Hive.openBox(TodoPrefs.todos);
    _todos = todosBox.values.toList();
    emit(TodosLoaded(todos: todos));
  }

  _addTodo(AddTodo event, Emitter<TodosState> emit) async {
    final state = this.state;
    if (state is TodosLoaded) {
      Box<Todo> todosBox = await Hive.openBox(TodoPrefs.todos);
      await todosBox.put(event.todo.id, event.todo);
      _todos = todosBox.values.toList();
      emit(TodosLoaded(todos: todos));
    }
  }

  _deleteTodo(DeleteTodo event, Emitter<TodosState> emit) async {
    final state = this.state;
    if (state is TodosLoaded) {
      Box<Todo> todosBox = await Hive.openBox(TodoPrefs.todos);
      await todosBox.delete(event.todo.id);
      _todos = todosBox.values.toList();
      emit(TodosLoaded(todos: todos));
    }
  }

  _updateTodo(TodoDone event, Emitter<TodosState> emit) async {
    final state = this.state;
    if (state is TodosLoaded) {
      Box<Todo> todosBox = await Hive.openBox(TodoPrefs.todos);
      await todosBox.put(event.todo.id, event.todo);
      _todos = todosBox.values.toList();
      emit(TodosLoaded(todos: todos));
    }
  }
}
